"""
Reformats the resource pack's item models and item definitions into a compact,
readable shape. Blockbench re-explodes these on every save, so this is meant to
be re-run after editing a model.

Rules:
  - Any value that contains no nested containers and fits in MAX columns is put
    on one line, so `"from": [0, 0, 1]` and a whole cube face stay compact.
  - `faces` blocks become an aligned table: names padded, uv columns aligned on
    the decimal point, and an explicit `rotation` on every face.
  - `display` blocks get the same treatment, ordered by DISPLAY_ORDER, with
    `scale`, `rotation` and `translation` present on every entry in that order.
  - `groups` become one aligned row per group, ordered by GROUP_FIELDS.
  - `elements` are sorted by their `from` corner, by y then z then x, and any
    `groups` that index them are rewritten to follow.
  - Numbers in a column align on the decimal point, so `2` and `0.65` render as
    `2   ` and `0.65` rather than being flush right.
  - The root object always expands, so a short file is never a single line.

Usage:
    py format_models.py
"""
import json
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # repo root (one level up from utils/)
ASSETS = ROOT / "resourcepack" / "assets"

MAX = 100  # inline anything that fits in this many columns, wrap otherwise

# Display contexts in the order they should appear. Anything not listed keeps
#  its original order and follows these.
DISPLAY_ORDER = ("gui", "ground", "fixed",
                 "firstperson_righthand", "firstperson_lefthand",
                 "thirdperson_righthand", "thirdperson_lefthand")

# Written on every display entry, in this order, when absent.
DISPLAY_FIELDS = (("scale", [1, 1, 1]),
                  ("rotation", [0, 0, 0]),
                  ("translation", [0, 0, 0]))


def inline(obj):
    """Single-line form, or None when the value contains nested containers."""
    if isinstance(obj, dict):
        parts = []
        for k, v in obj.items():
            s = inline(v)
            if s is None:
                return None
            parts.append(f"{json.dumps(k)}: {s}")
        return "{" + ", ".join(parts) + "}" if parts else "{}"
    if isinstance(obj, list):
        parts = []
        for v in obj:
            if isinstance(v, (dict, list)):
                return None
            parts.append(json.dumps(v))
        return "[" + ", ".join(parts) + "]" if parts else "[]"
    return json.dumps(obj)


def split_number(value):
    """Splits a rendered number into its integer part and its fractional tail."""
    text = json.dumps(value)
    if "." in text:
        whole, frac = text.split(".", 1)
        return whole, "." + frac
    return text, ""


def decimal_spec(values):
    """Widths either side of the decimal point across a set of numbers."""
    parts = [split_number(v) for v in values]
    return (max((len(w) for w, _ in parts), default=0),
            max((len(f) for _, f in parts), default=0))


def decimal_align(value, spec):
    whole, frac = split_number(value)
    return whole.rjust(spec[0]) + frac.ljust(spec[1])


def vector_specs(vectors):
    ncol = max((len(v) for v in vectors), default=0)
    return [decimal_spec([v[i] for v in vectors if i < len(v)]) for i in range(ncol)]


def fmt_table(entries, depth, fields, extras_first=None):
    """Renders a dict-of-dicts as an aligned table.

    `fields` is a sequence of (name, default) rendered in order on every row;
    `extras_first` is a field rendered ahead of them when present."""
    pad, inner = "  " * depth, "  " * (depth + 1)
    keyw = max(len(json.dumps(k)) + 1 for k in entries)

    specs = {}
    for name in ([extras_first] if extras_first else []) + [n for n, _ in fields]:
        default = dict(fields).get(name)
        values = [e.get(name, default) for e in entries.values()]
        values = [v for v in values if v is not None]
        if values and all(isinstance(v, list) for v in values):
            specs[name] = vector_specs(values)
        elif values and all(not isinstance(v, (list, dict)) for v in values):
            specs[name] = decimal_spec(values)

    def render(name, value):
        spec = specs.get(name)
        if isinstance(value, list) and isinstance(spec, list):
            cells = [decimal_align(v, spec[i]) for i, v in enumerate(value)]
            return "[" + ", ".join(cells) + "]"
        if spec and not isinstance(spec, list):
            return decimal_align(value, spec)
        return inline(value)

    handled = {extras_first} | {n for n, _ in fields}
    rows = []
    for key, entry in entries.items():
        parts = []
        if extras_first and entry.get(extras_first) is not None:
            parts.append(f"{json.dumps(extras_first)}: {render(extras_first, entry[extras_first])}")
        for name, default in fields:
            parts.append(f"{json.dumps(name)}: {render(name, entry.get(name, default))}")
        for k, v in entry.items():
            if k not in handled:
                parts.append(f"{json.dumps(k)}: {inline(v)}")
        rows.append(inner + (json.dumps(key) + ":").ljust(keyw) + " {" + ", ".join(parts) + "}")

    return "{\n" + ",\n".join(rows) + "\n" + pad + "}"


# Fields written on every group row, in this order. Anything else follows.
GROUP_FIELDS = ("name", "origin", "scope", "color", "children")


def fmt_groups(groups, depth):
    """Renders a list of groups as one aligned row each.

    Every column is padded to a common width, so names, origins and child
    indices line up down the list."""
    pad, inner = "  " * depth, "  " * (depth + 1)

    specs = {}
    for name in GROUP_FIELDS:
        values = [g[name] for g in groups if name in g]
        if not values:
            continue
        if all(isinstance(v, list) for v in values) and \
                all(isinstance(x, (int, float)) for v in values for x in v):
            specs[name] = vector_specs(values)
        elif all(isinstance(v, (int, float)) and not isinstance(v, bool) for v in values):
            specs[name] = decimal_spec(values)

    def render(name, value):
        spec = specs.get(name)
        if isinstance(spec, list) and isinstance(value, list):
            return "[" + ", ".join(decimal_align(v, spec[i]) for i, v in enumerate(value)) + "]"
        if spec:
            return decimal_align(value, spec)
        return inline(value)

    rows = []
    for group in groups:
        keys = ([k for k in GROUP_FIELDS if k in group]
                + [k for k in group if k not in GROUP_FIELDS])
        rows.append([(k, f"{json.dumps(k)}: {render(k, group[k])}") for k in keys])

    width = {}
    for row in rows:
        for name, cell in row:
            width[name] = max(width.get(name, 0), len(cell))

    # The comma is padded with the cell it follows, so it stays against the value
    lines = []
    for row in rows:
        cells = [cell if i == len(row) - 1 else (cell + ",").ljust(width[name] + 2)
                 for i, (name, cell) in enumerate(row)]
        lines.append(inner + "{" + "".join(cells) + "}")

    return "[\n" + ",\n".join(lines) + "\n" + pad + "]"


def order_display(display):
    """Display contexts in DISPLAY_ORDER, with anything unlisted appended."""
    known = [k for k in DISPLAY_ORDER if k in display]
    rest = [k for k in display if k not in DISPLAY_ORDER]
    return {k: display[k] for k in known + rest}


def sort_elements(model):
    """Orders `elements` by their `from` corner: y, then z, then x.

    Groups address elements by index, so those references are rewritten to
    follow the elements they point at."""
    elements = model.get("elements")
    if not isinstance(elements, list) or not all(isinstance(e, dict) for e in elements):
        return

    def key(index):
        corner = elements[index].get("from", [0, 0, 0])
        corner = list(corner) + [0] * (3 - len(corner))
        return (corner[1], corner[2], corner[0])

    order = sorted(range(len(elements)), key=key)
    moved = {old: new for new, old in enumerate(order)}
    model["elements"] = [elements[i] for i in order]

    def remap(node):
        # A child is either an element index or a nested group
        if isinstance(node, dict) and isinstance(node.get("children"), list):
            node["children"] = [remap(c) for c in node["children"]]
            return node
        return moved.get(node, node) if isinstance(node, int) else node

    groups = model.get("groups")
    if isinstance(groups, list):
        model["groups"] = [remap(g) for g in groups]


def fmt(obj, depth=0, key=None):
    pad, inner = "  " * depth, "  " * (depth + 1)
    is_table = isinstance(obj, dict) and obj and all(isinstance(v, dict) for v in obj.values())

    if key == "faces" and is_table:
        return fmt_table(obj, depth, (("rotation", 0),), extras_first="uv")
    if key == "display" and is_table:
        return fmt_table(order_display(obj), depth, DISPLAY_FIELDS)
    if key == "groups" and isinstance(obj, list) and obj and all(isinstance(v, dict) for v in obj):
        return fmt_groups(obj, depth)
    # The root object always expands, so a whole short file is not one line.
    if depth > 0:
        flat = inline(obj)
        if flat is not None and len(pad) + len(flat) <= MAX:
            return flat

    if isinstance(obj, dict):
        body = ",\n".join(f"{inner}{json.dumps(k)}: {fmt(v, depth + 1, k)}" for k, v in obj.items())
        return "{\n" + body + "\n" + pad + "}"
    if isinstance(obj, list):
        body = ",\n".join(inner + fmt(v, depth + 1) for v in obj)
        return "[\n" + body + "\n" + pad + "]"
    return json.dumps(obj)


def main() -> None:
    if not ASSETS.is_dir():
        sys.exit(f"assets folder not found at {ASSETS}")

    targets = sorted(list(ASSETS.glob("*/models/**/*.json"))
                     + list(ASSETS.glob("*/items/**/*.json")))
    if not targets:
        sys.exit("no model or item definition files found")

    for path in targets:
        before = len(path.read_bytes().decode("utf-8").splitlines())
        model = json.loads(path.read_text(encoding="utf-8"))
        sort_elements(model)
        text = fmt(model) + "\n"
        path.write_bytes(text.replace("\n", "\r\n").encode("utf-8"))
        rel = path.relative_to(ASSETS).as_posix()
        print(f"{rel}  {before} -> {len(text.splitlines())} lines")

    print(f"Formatted {len(targets)} files")


if __name__ == "__main__":
    main()
