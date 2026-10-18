"""Writes what the ghost rails are drawn with: the see-through textures, and the
two models of the ghost of a curve.

Each texture a rail model uses is written with every pixel that shows at
GHOST_ALPHA instead. 'rail_ghost' is the pack's own rail, which the straight
rail and the ghost of a straight rail are drawn with. The curved rail also uses
the vanilla rail and rail corner textures, so the ghost of a curve takes
'vanilla_rail_ghost' and 'vanilla_rail_corner_ghost' from the client jar's.

The ghost of a curve shows over the end's straight rail, which the curve's own
straight run in from the edge the track came in by would lie on exactly, so
each model leaves that run out: 'rail_curved_ghost_from_south' the run in from
the south edge, the curve's elements from LEAD on south, and
'rail_curved_ghost_from_east' the run in from the east, those from LEAD on
east. The rest of the curve still crosses the straight rail, so every element
is grown GROW pixels each way, held inside the model's limits, to lie just
outside the straight rail's faces.

Run from the repository root: py -3 utils/generate_rail_ghosts.py
"""
import json
import sys
import zipfile
from pathlib import Path

import _png

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
ASSETS = ROOT / "resourcepack" / "assets" / "derailed"
TEXTURES = ASSETS / "textures" / "block"
JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"

GHOST_ALPHA = 127
LEAD = 20
GROW = 0.01
LIMITS = (-16, 32)

CURVE_TEXTURES = {
    "particle": "derailed:block/vanilla_rail_ghost",
    "2": "derailed:block/vanilla_rail_ghost",
    "rail_corner": "derailed:block/vanilla_rail_corner_ghost",
    "dr_rail": "derailed:block/rail_ghost",
}

# Each ghost texture and where its texture comes from: the pack's own, or the
#  client jar's
GHOSTS = [
    ("rail_ghost", "pack", "rail"),
    ("vanilla_rail_ghost", "jar", "assets/minecraft/textures/block/rail.png"),
    ("vanilla_rail_corner_ghost", "jar", "assets/minecraft/textures/block/rail_corner.png"),
]


def grown(element):
    """The element GROW pixels bigger each way, held inside LIMITS"""
    out = dict(element)
    low = [min(a, b) for a, b in zip(element["from"], element["to"])]
    high = [max(a, b) for a, b in zip(element["from"], element["to"])]
    out["from"] = [round(max(LIMITS[0], v - GROW), 4) for v in low]
    out["to"] = [round(min(LIMITS[1], v + GROW), 4) for v in high]
    return out


def write_curve(name, elements):
    lines = [
        "{",
        '  "ambientocclusion": false,',
        '  "textures": ' + json.dumps(CURVE_TEXTURES, separators=(", ", ": ")) + ",",
        '  "elements": [',
    ]
    lines += ["    " + json.dumps(e, separators=(", ", ": ")) + ("," if i < len(elements) - 1 else "")
              for i, e in enumerate(elements)]
    lines += ["  ]", "}"]
    path = ASSETS / "models" / "item" / (name + ".json")
    with open(path, "w", newline="\r\n") as f:
        f.write("\n".join(lines) + "\n")
    print("wrote", path.relative_to(ROOT), "-", len(elements), "elements")


def main():
    if not JAR.exists():
        sys.exit("no client jar at %s" % JAR)
    jar = zipfile.ZipFile(JAR)
    for name, source, path in GHOSTS:
        data = (TEXTURES / (path + ".png")).read_bytes() if source == "pack" else jar.read(path)
        width, height, pixels = _png.read(data)
        ghost = [(r, g, b, GHOST_ALPHA if a else 0) for r, g, b, a in pixels]
        out = TEXTURES / (name + ".png")
        _png.write(str(out), width, height, ghost)
        print("wrote", out.relative_to(ROOT))

    curve = json.loads((ASSETS / "models" / "block" / "rail_curved.json").read_text())["elements"]
    south = [e for e in curve if min(e["from"][2], e["to"][2]) < LEAD]
    east = [e for e in curve if min(e["from"][0], e["to"][0]) < LEAD]
    write_curve("rail_curved_ghost_from_south", [grown(e) for e in south])
    write_curve("rail_curved_ghost_from_east", [grown(e) for e in east])


if __name__ == "__main__":
    main()
