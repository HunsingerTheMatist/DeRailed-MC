"""
Turns an item model a quarter turn about the y axis, baking the rotation into
the coordinates rather than leaving it to a per-element `rotation` block.

Models authored facing different ways need different `display` blocks to sit
right in the hand, so it is worth having them all agree. A quarter turn on
axis-aligned boxes is exact: integer coordinates land on integer coordinates
and no faces come out skewed.

What moves:
  - `from` and `to` corners, renormalised so each axis still runs low to high.
  - Face keys, since the face that pointed east now points south.
  - `cullface` values, for the same reason.
  - Element rotation origins. The angle itself is unchanged - rotating a
    rotation about the same axis only moves where it pivots.
  - `up` and `down` texture rotations. Those two faces take their uv frame from
    the world rather than the model, so the texture has to be turned to keep up.
  - The `display` angles listed in DISPLAY_ANGLES.

Usage:
    py rotate_model.py
"""
import json
import sys
from pathlib import Path

from format_models import fmt, sort_elements

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # repo root (one level up from utils/)
MODELS = ROOT / "resourcepack" / "assets" / "derailed" / "models" / "item"

# (source model, model written out). Turning is not idempotent, so this is left
#  empty between uses - a second run over the same model turns it again
TARGETS = ()

SIZE = 16  # the block the model is authored in, so the turn pivots on its middle

# A quarter turn anticlockwise seen from above: x' = SIZE - z, z' = x
FACE_MOVES = {"east": "south", "south": "west", "west": "north", "north": "east"}

# `up` is seen from above and `down` from below, so the same turn reads opposite
#  ways round on them
UV_TURN = {"up": 90, "down": -90}

# The display angles each context settles on, taken from rail1. A number sets
#  the y angle and leaves the tilt alone; a triple replaces all three. Any
#  context missing from here is left as it was
# Thirdperson needs the triple because a y of 90 is gimbal locked: Rx*Ry*Rz
#  collapses to depend only on x + z, so [0, 90, 90] and [90, 90, 0] are one
#  rotation and there is no tilt left to keep. All three have to be stated
DISPLAY_ANGLES = {
    "gui": -39,
    "firstperson_righthand": -10,
    "firstperson_lefthand": 10,
    "thirdperson_righthand": [90, 0, 0],
    "thirdperson_lefthand": [90, 0, 0],
}


def turned_point(x, z):
    return SIZE - z, x


def turned_box(corner_a, corner_b):
    """The two corners after turning, put back in low-to-high order."""
    ax, az = turned_point(corner_a[0], corner_a[2])
    bx, bz = turned_point(corner_b[0], corner_b[2])
    return ([min(ax, bx), corner_a[1], min(az, bz)],
            [max(ax, bx), corner_b[1], max(az, bz)])


def turned_faces(faces):
    moved = {}
    for side, face in faces.items():
        face = dict(face)
        if "cullface" in face:
            face["cullface"] = FACE_MOVES.get(face["cullface"], face["cullface"])
        if side in UV_TURN:
            face["rotation"] = (face.get("rotation", 0) + UV_TURN[side]) % 360
        moved[FACE_MOVES.get(side, side)] = face
    return moved


def turned_rotation(rotation, source):
    """Only the pivot moves; a turn about the same axis leaves the angle alone."""
    if rotation is None:
        return None
    rotation = dict(rotation)
    if "axis" in rotation and rotation["axis"] != "y":
        sys.exit(f"{source}: rotation about {rotation['axis']} needs its axis remapped by hand")
    for field in ("x", "z"):
        if rotation.get(field, 0) != 0:
            sys.exit(f"{source}: rotation has a {field} component, which this cannot turn")
    origin = rotation["origin"]
    ox, oz = turned_point(origin[0], origin[2])
    rotation["origin"] = [ox, origin[1], oz]
    return rotation


def tidy(vector):
    return [int(v) if float(v).is_integer() else v for v in vector]


def main() -> None:
    if not MODELS.is_dir():
        sys.exit(f"models folder not found at {MODELS}")

    for source, target in TARGETS:
        path = MODELS / f"{source}.json"
        if not path.is_file():
            sys.exit(f"{path} not found")
        model = json.loads(path.read_text(encoding="utf-8"))

        for element in model.get("elements", []):
            low, high = turned_box(element["from"], element["to"])
            element["from"], element["to"] = tidy(low), tidy(high)
            element["faces"] = turned_faces(element["faces"])
            rotation = turned_rotation(element.get("rotation"), source)
            if rotation is not None:
                rotation["origin"] = tidy(rotation["origin"])
                element["rotation"] = rotation

        for group in model.get("groups", []):
            if isinstance(group, dict) and "origin" in group:
                ox, oz = turned_point(group["origin"][0], group["origin"][2])
                group["origin"] = tidy([ox, group["origin"][1], oz])

        for context, entry in model.get("display", {}).items():
            if context not in DISPLAY_ANGLES:
                continue
            wanted = DISPLAY_ANGLES[context]
            was = list(entry.get("rotation", [0, 0, 0]))
            entry["rotation"] = list(wanted) if isinstance(wanted, list) else [was[0], wanted, was[2]]
            print(f"    display {context:22} {was} -> {entry['rotation']}")

        sort_elements(model)
        out = MODELS / f"{target}.json"
        out.write_bytes((fmt(model) + "\n").replace("\n", "\r\n").encode("utf-8"))

        spans = []
        for axis, label in enumerate("xyz"):
            lo = min(e["from"][axis] for e in model["elements"])
            hi = max(e["to"][axis] for e in model["elements"])
            spans.append(f"{label}={hi - lo}")
        print(f"  {source}.json -> {out.name}  ({len(model['elements'])} elements, span {' '.join(spans)})")

    print(f"Turned {len(TARGETS)} models")


if __name__ == "__main__":
    main()
