"""Writes the gravel the track lies on: 'rail_gravel' under a straight rail and
'rail_gravel_curved' under a curved one, a texture 48 pixels square and a model
of the same name each, covering a whole three-block tile.

The gravel is pebbles cut from one 16 pixel tile made from the vanilla gravel
texture: pebbles of one to seven pixels, rounded, placed at random from SEED
until about half the tile is covered, none touching another along a side,
wrapping across the edges so the tile repeats seamlessly. Each keeps the
gravel's pixels, and each stands a height of its own, drawn from a normal
spread round HEIGHT_MEAN pixels, HEIGHT_SPREAD wide, held between HEIGHT_MIN
and HEIGHT_MAX.

The tile is repeated across the 48 pixels and each pebble kept or dropped whole
by where its middle falls, within BAND/2 of the line the rail's middle follows,
so no edge shows half a pebble: straight across the middle of the tile for the
straight rail, and for the curved rail straight in from the tile's southern and
eastern edges until it turns on an arc of CURVE_RADIUS round CURVE_CENTRE, as
the rail_curved model runs, drawn in on the outside of the turn to an arc round
OUTER_CENTRE. A pebble the same in every repeat stands the same
height in every repeat, so the gravel of one tile meets the next.

The texture holds the kept pebbles' pixels and the model stands each pebble as
boxes, one for each rectangle its pixels split into, from the ground up its
height, its top and sides drawn from those pixels. Texture pixels match model
pixels, the tile's northwestern corner at -16, -16 of its middle block.

Run from the repository root: py -3 utils/generate_rail_gravel.py
"""
import json
import math
import random
import sys
import zipfile
from pathlib import Path

import _png

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
ASSETS = ROOT / "resourcepack" / "assets" / "derailed"
JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"

SEED = 0
COVER = 0.5
TILE = 16
SIZE = 48
ORIGIN = -16
BAND = 32
RAIL_X = 8
CURVE_CENTRE = 19
CURVE_RADIUS = 11
OUTER_CENTRE = 23
HEIGHT_MEAN = 0.5
HEIGHT_SPREAD = 0.2
HEIGHT_MIN = 0.1
HEIGHT_MAX = 1.0
INSET = 0.02

# Pebbles as pixel offsets, rounded 2x2 to 3x3, and a single pixel for the gaps
#  once the tile is nearly full
SHAPES = [
    [(0, 0), (1, 0), (0, 1), (1, 1)],
    [(0, 0), (1, 0), (2, 0), (0, 1), (1, 1), (2, 1)],
    [(0, 0), (1, 0), (0, 1), (1, 1), (0, 2), (1, 2)],
    [(1, 0), (0, 1), (1, 1), (2, 1), (1, 2), (0, 2), (2, 2)],
    [(1, 0), (2, 0), (0, 1), (1, 1), (2, 1), (1, 2)],
    [(1, 0), (0, 1), (1, 1), (2, 1), (0, 2), (1, 2), (2, 2)],
]
SINGLE = [(0, 0)]


def pebble_tile():
    """The tile's pebbles, each a list of pixels unwrapped across the edges,
    and the height each stands"""
    rng = random.Random(SEED)
    taken = [[False] * TILE for _ in range(TILE)]
    pebbles, filled, tries = [], 0, 0
    while filled < COVER * TILE * TILE and tries < 20000:
        tries += 1
        shape = rng.choice(SHAPES + [SINGLE] if filled >= 0.45 * TILE * TILE else SHAPES)
        ox, oy = rng.randrange(TILE), rng.randrange(TILE)
        cells = [(ox + dx, oy + dy) for dx, dy in shape]
        if any(taken[y % TILE][x % TILE] for x, y in cells):
            continue
        pebbles.append(cells)
        filled += len(cells)
        for x, y in cells:
            for ax, ay in ((0, 0), (1, 0), (-1, 0), (0, 1), (0, -1)):
                taken[(y + ay) % TILE][(x + ax) % TILE] = True

    # The heights come from a generator of their own, so the layout stays the
    #  one SEED has always given
    heights_rng = random.Random(SEED + 1)
    heights = [round(min(HEIGHT_MAX, max(HEIGHT_MIN, heights_rng.gauss(HEIGHT_MEAN, HEIGHT_SPREAD))), 2)
               for _ in pebbles]
    return pebbles, heights


def kept(pebbles, keep):
    """Every repeat across the texture of every pebble whose middle, in model
    pixels, 'keep' accepts: its height and the pixels of it inside the texture"""
    out = []
    for i, cells in enumerate(pebbles):
        mx = sum(x + 0.5 for x, _ in cells) / len(cells)
        my = sum(y + 0.5 for _, y in cells) / len(cells)
        for ax in range(-TILE, SIZE + TILE, TILE):
            for ay in range(-TILE, SIZE + TILE, TILE):
                if not keep(ORIGIN + ax + mx, ORIGIN + ay + my):
                    continue
                inside = [(ax + x, ay + y, x % TILE, y % TILE) for x, y in cells
                          if 0 <= ax + x < SIZE and 0 <= ay + y < SIZE]
                if inside:
                    out.append((i, inside))
    return out


def straight(x, z):
    return abs(x - RAIL_X) <= BAND / 2


def curved(x, z):
    """Within BAND/2 of the curved rail's middle line: straight in along x
    RAIL_X from the south and z RAIL_X from the east, turning between them on an
    arc of CURVE_RADIUS round CURVE_CENTRE
    The outside of the turn is drawn in closer, to an arc round OUTER_CENTRE
    that meets the band's straight outer edges, so as much shows outside the
    outer rail round the turn as looks right beside a straight one"""
    c, r = CURVE_CENTRE, CURVE_RADIUS
    from_south = abs(x - RAIL_X) if z >= c else math.hypot(x - RAIL_X, z - c)
    from_east = abs(z - RAIL_X) if x >= c else math.hypot(z - RAIL_X, x - c)
    distance = min(from_south, from_east)
    if x <= c and z <= c:
        distance = min(distance, abs(math.hypot(x - c, z - c) - r))
    o = OUTER_CENTRE
    edge = RAIL_X - BAND / 2
    if x <= o and z <= o and math.hypot(x - o, z - o) > o - edge:
        return False
    return distance <= BAND / 2


def shift_out(copies):
    """Moves each pebble on the outside of the turn straight out from
    OUTER_CENTRE towards the arc the outside is drawn in to, so the arc shows
    no dents where the pebble beyond one was dropped: as far as it goes without
    leaving the arc or coming beside another pebble along a side, and only
    where that takes it within a pixel of the arc, so pebbles inside the band
    stay put"""
    centre = OUTER_CENTRE - ORIGIN
    radius = OUTER_CENTRE - (RAIL_X - BAND / 2)

    def reach(pixels):
        return max(math.hypot(px + 0.5 - centre, pz + 0.5 - centre) for px, pz, _, _ in pixels)

    owner = {}
    for n, (_, inside) in enumerate(copies):
        for px, pz, _, _ in inside:
            owner[(px, pz)] = n

    def free(pixels, n):
        for px, pz, _, _ in pixels:
            for ax, az in ((0, 0), (1, 0), (-1, 0), (0, 1), (0, -1)):
                if owner.get((px + ax, pz + az), n) != n:
                    return False
        return True

    outside = [n for n, (_, inside) in enumerate(copies)
               if all(px + 0.5 <= centre and pz + 0.5 <= centre for px, pz, _, _ in inside)]
    # Nearest the arc first, so a pebble behind another sees it where it ends up
    for n in sorted(outside, key=lambda n: radius - reach(copies[n][1])):
        i, inside = copies[n]
        gap = radius - reach(inside)
        if gap < 1.5:
            continue
        mx = sum(px + 0.5 for px, _, _, _ in inside) / len(inside) - centre
        mz = sum(pz + 0.5 for _, pz, _, _ in inside) / len(inside) - centre
        length = math.hypot(mx, mz)
        best = None
        for step in range(1, int(gap) + 1):
            dx, dz = round(mx / length * step), round(mz / length * step)
            moved = [(px + dx, pz + dz, tx, tz) for px, pz, tx, tz in inside]
            if reach(moved) > radius or not free(moved, n):
                break
            best = moved
        if best is None or radius - reach(best) > 1:
            continue
        for px, pz, _, _ in inside:
            del owner[(px, pz)]
        for px, pz, _, _ in best:
            owner[(px, pz)] = n
        copies[n] = (i, best)
    return copies


def rectangles(pixels):
    """Splits a set of texture pixels into rectangles, (x0, z0, x1, z1) with the
    far sides exclusive: runs along each row, and runs the same across stacked"""
    runs = []
    for z in sorted({z for _, z in pixels}):
        xs = sorted(x for x, zz in pixels if zz == z)
        start = prev = xs[0]
        for x in xs[1:] + [None]:
            if x is not None and x == prev + 1:
                prev = x
                continue
            runs.append([start, z, prev + 1, z + 1])
            if x is not None:
                start = prev = x
    merged = []
    for run in runs:
        for rect in merged:
            if rect[0] == run[0] and rect[2] == run[2] and rect[3] == run[1]:
                rect[3] = run[3]
                break
        else:
            merged.append(run)
    return merged


def uv(x0, z0, x1, z1):
    scale = 16 / SIZE
    return [round(x0 * scale, 4), round(z0 * scale, 4), round(x1 * scale, 4), round(z1 * scale, 4)]


def box(rect, height):
    """A pebble's box over the texture pixels of 'rect', the top showing them
    and each side its edge pixel along that side, drawn in INSET on every side
    across so no side lies in the same plane as a rail's plank"""
    x0, z0, x1, z1 = rect
    mid_x, mid_z = (x0 + x1) // 2, (z0 + z1) // 2
    faces = {
        "up": {"uv": uv(x0, z0, x1, z1), "texture": "#gravel"},
        "north": {"uv": uv(x0, z0, x1, z0 + 1), "texture": "#gravel"},
        "south": {"uv": uv(x0, z1 - 1, x1, z1), "texture": "#gravel"},
        "west": {"uv": uv(x0, mid_z, x0 + 1, mid_z + 1), "texture": "#gravel"},
        "east": {"uv": uv(x1 - 1, mid_z, x1, mid_z + 1), "texture": "#gravel"},
    }
    return {"from": [ORIGIN + x0 + INSET, 0, ORIGIN + z0 + INSET],
            "to": [ORIGIN + x1 - INSET, height, ORIGIN + z1 - INSET], "faces": faces}


def write_model(name, elements):
    lines = [
        "{",
        '  "ambientocclusion": false,',
        '  "textures": {"particle": "derailed:block/rail", "gravel": "derailed:block/%s"},' % name,
        '  "elements": [',
    ]
    lines += ["    " + json.dumps(e, separators=(", ", ": ")) + ("," if i < len(elements) - 1 else "")
              for i, e in enumerate(elements)]
    lines += ["  ]", "}"]
    path = ASSETS / "models" / "block" / (name + ".json")
    with open(path, "w", newline="\r\n") as f:
        f.write("\n".join(lines) + "\n")
    return path


def main():
    if not JAR.exists():
        sys.exit("no client jar at %s" % JAR)
    width, height, gravel = _png.read(zipfile.ZipFile(JAR).read("assets/minecraft/textures/block/gravel.png"))
    if (width, height) != (TILE, TILE):
        sys.exit("gravel is %dx%d, not %dx%d" % (width, height, TILE, TILE))
    pebbles, heights = pebble_tile()
    for name, keep in (("rail_gravel", straight), ("rail_gravel_curved", curved)):
        copies = kept(pebbles, keep)
        if keep is curved:
            copies = shift_out(copies)
        pixels = [(0, 0, 0, 0)] * (SIZE * SIZE)
        elements = []
        for i, inside in copies:
            for px, pz, tx, tz in inside:
                pixels[pz * SIZE + px] = gravel[tz * TILE + tx]
            for rect in rectangles({(px, pz) for px, pz, _, _ in inside}):
                elements.append(box(rect, heights[i]))
        texture = ASSETS / "textures" / "block" / (name + ".png")
        _png.write(str(texture), SIZE, SIZE, pixels)
        model = write_model(name, elements)
        print("wrote", texture.relative_to(ROOT), "and", model.relative_to(ROOT), "-", len(elements), "boxes")


if __name__ == "__main__":
    main()
