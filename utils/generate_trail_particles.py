"""Writes the textures the hidden chests' sparkles are drawn with, and points the
trail particle at them.

The chests sparkle with the trail particle, which glides from where it is
spawned to a target and takes a colour. It stands 'TRAIL' across, against the
portal particle's 'PORTAL' on average, and is drawn with the client jar's
'generic_0' alone, a single pixel. The eight textures 'generic_0' to
'generic_7', a single pixel up to a scatter filling the whole 8 by 8, which the
portal particle takes one of at random, are written again as
'derailed:spark_<n>', each the whole of its 8 by 8 drawn in the middle of the
trail's square at 'TIMES' the size it shows at on a portal particle, the
smallest 'KEEP' of them only, and the trail particle takes one of those at
random. They are drawn on a canvas of
'SIZE' across, which gives each pixel a whole number of the canvas's.

Run from the repository root: py -3 utils/generate_trail_particles.py
"""
import json
import sys
import zipfile
from pathlib import Path

import _png

ROOT = Path(__file__).resolve().parent.parent
JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"
ASSETS = ROOT / "resourcepack" / "assets"

PORTAL = 0.06
TRAIL = 0.26
TIMES = 2
KEEP = 6
SIZE = 52


def drawn(width, pixels):
    side = SIZE * TIMES * PORTAL / TRAIL
    per = side / width
    if abs(per - round(per)) > 1e-6:
        sys.exit("a pixel would be %.3f of the canvas's, not a whole number" % per)
    per = int(round(per))
    start = (SIZE - per * width) // 2
    out = [(0, 0, 0, 0)] * (SIZE * SIZE)
    for y in range(width):
        for x in range(width):
            for dy in range(per):
                for dx in range(per):
                    out[(start + y * per + dy) * SIZE + start + x * per + dx] = pixels[y * width + x]
    return out


def main():
    if not JAR.exists():
        sys.exit("no client jar at %s" % JAR)
    jar = zipfile.ZipFile(JAR)
    folder = ASSETS / "derailed" / "textures" / "particle"
    folder.mkdir(parents=True, exist_ok=True)
    textures = []
    for n in range(KEEP):
        width, height, pixels = _png.read(jar.read("assets/minecraft/textures/particle/generic_%d.png" % n))
        if width != height:
            sys.exit("generic_%d is not square" % n)
        out = drawn(width, pixels)
        _png.write(str(folder / ("spark_%d.png" % n)), SIZE, SIZE, out)
        textures.append("derailed:spark_%d" % n)
    particles = ASSETS / "minecraft" / "particles"
    particles.mkdir(parents=True, exist_ok=True)
    with open(particles / "trail.json", "w", newline="\r\n") as f:
        f.write(json.dumps({"textures": textures}, indent=2) + "\n")


if __name__ == "__main__":
    main()
