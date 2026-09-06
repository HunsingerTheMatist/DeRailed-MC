"""
Generates stacked pile models from a single base model.

A pile of two wood is just the wood model with a second copy sitting on top, and
a pile of three adds a third. Keeping those by hand means making every geometry
edit two and three times, so only the base model is authored and the stacked
variants are built from it.

Each stack is described in STACKS as (series name, pixels per layer, highest
variant to emit). The single-layer model is authored as <series>1.json, so a
series of "wood" at 9px up to 3 reads wood1.json and writes wood2.json and
wood3.json.

Only `elements` is generated. Everything else in an existing variant is kept as
it is, so per-variant hand tuning - a taller pile scaled down to fit the GUI
slot, for instance - survives regeneration.

Output goes through the same formatter as format_models.py, so regenerating and
reformatting produce identical files.

Usage:
    py generate_stacked_models.py
"""
import json
import sys
from pathlib import Path

from format_models import fmt

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # repo root (one level up from utils/)
MODELS = ROOT / "resourcepack" / "assets" / "derailed" / "models" / "item"

# (series name, pixels between layers, highest variant to emit)
STACKS = (
    ("wood", 9, 3),
    ("_small_wood", 6, 3),
    ("_small_iron", 6, 3),
)


def shifted(elements, dy):
    """A deep copy of the elements moved dy pixels up the y axis."""
    copy = json.loads(json.dumps(elements))
    for element in copy:
        element["from"][1] += dy
        element["to"][1] += dy
        rotation = element.get("rotation")
        if isinstance(rotation, dict) and "origin" in rotation:
            rotation["origin"][1] += dy
    return copy


def build(base_model, existing, step, layers):
    """Geometry repeated `layers` times and stacked, written into `existing`
    when there is one so its own display transforms are not lost."""
    model = json.loads(json.dumps(existing if existing is not None else base_model))
    elements = []
    for layer in range(layers):
        elements += shifted(base_model["elements"], step * layer)
    model["elements"] = elements
    return model


def main() -> None:
    if not MODELS.is_dir():
        sys.exit(f"models folder not found at {MODELS}")

    written = 0
    for series, step, highest in STACKS:
        base_path = MODELS / f"{series}1.json"
        if not base_path.is_file():
            sys.exit(f"base model not found: {base_path}")
        base_model = json.loads(base_path.read_text(encoding="utf-8"))

        for layers in range(2, highest + 1):
            out_path = MODELS / f"{series}{layers}.json"
            existing = None
            if out_path.is_file():
                existing = json.loads(out_path.read_text(encoding="utf-8"))

            text = fmt(build(base_model, existing, step, layers)) + "\n"
            out_path.write_bytes(text.replace("\n", "\r\n").encode("utf-8"))

            kept = "kept existing display" if existing else "new file"
            count = len(base_model["elements"]) * layers
            print(f"{out_path.name}  {layers} layers, {count} elements, {kept}")
            written += 1

    print(f"Generated {written} models")


if __name__ == "__main__":
    main()
