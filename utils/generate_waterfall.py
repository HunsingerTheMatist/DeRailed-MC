"""Writes the waterfall the full-size build hangs off the map's water: a flat
sheet of falling water three blocks wide and twenty high, seen from both sides.

- 'derailed:block/waterfall', the client jar's flowing water texture run
  'SPEED' times as fast: the flowing water already moves on a frame every tick,
  as fast as a texture can go, so only every 'SPEED'th frame is kept, from the
  first, and the frames after the last of them are left out
- 'derailed:item/waterfall', a sheet of three by twenty squares, each the part
  of the texture a vanilla waterfall shows on the side of a block, none of them
  shaded and every face tinted. A model can reach no further than three blocks
  across, so the sheet is three blocks high in the model and stood twenty high
  by the display's scale, 'SCALE_Y'
- 'derailed:waterfall', the item model, which tints the sheet the forest biome's
  water colour, 'WATER'

The sheet is a single plane with a face to the north and a face to the south,
across the middle of the model from side to side.

Run from the repository root: py -3 utils/generate_waterfall.py
"""
import json
import sys
import zipfile
from pathlib import Path

import _png

ROOT = Path(__file__).resolve().parent.parent
JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"
ASSETS = ROOT / "resourcepack" / "assets" / "derailed"

SPEED = 2
WIDE = 3
HIGH = 20
SCALE_Y = HIGH / WIDE
WATER = 0x3F76E4


def texture(jar):
    width, height, pixels = _png.read(jar.read("assets/minecraft/textures/block/water_flow.png"))
    frames = height // width
    kept = []
    for frame in range(0, frames, SPEED):
        kept += pixels[frame * width * width:(frame + 1) * width * width]
    path = ASSETS / "textures" / "block" / "waterfall.png"
    path.parent.mkdir(parents=True, exist_ok=True)
    _png.write(str(path), width, len(kept) // width, kept)
    with open(str(path) + ".mcmeta", "w", newline="\r\n") as f:
        f.write(json.dumps({"animation": {}}, indent=2) + "\n")


def model():
    side = 16 * WIDE
    row = side / HIGH
    elements = []
    for r in range(HIGH):
        for c in range(WIDE):
            face = {"uv": [0, 0, 8, 8], "texture": "#water", "tintindex": 0}
            elements.append({
                "from": [-16 + 16 * c, round(-16 + row * r, 4), 8],
                "to": [16 * c, round(-16 + row * (r + 1), 4), 8],
                "shade": False,
                "faces": {"north": dict(face), "south": dict(face)},
            })
    body = {"textures": {"water": "derailed:block/waterfall", "particle": "derailed:block/waterfall"},
            "elements": elements}
    path = ASSETS / "models" / "item" / "waterfall.json"
    with open(path, "w", newline="\r\n") as f:
        f.write(json.dumps(body, indent=2) + "\n")


def item():
    body = {"model": {"type": "minecraft:model", "model": "derailed:item/waterfall",
                      "tints": [{"type": "minecraft:constant", "value": WATER}]}}
    with open(ASSETS / "items" / "waterfall.json", "w", newline="\r\n") as f:
        f.write(json.dumps(body, indent=2) + "\n")


def main():
    if not JAR.exists():
        sys.exit("no client jar at %s" % JAR)
    texture(zipfile.ZipFile(JAR))
    model()
    item()
    print("wrote the waterfall's texture, model and item model; stand it %.6f high" % SCALE_Y)


if __name__ == "__main__":
    main()
