"""Writes the river pieces laid at full size where one river meets another.

A river's surface is drawn by waterlogged walls on its water, each kind of wall
the flow in one direction, in steps of 22.5 degrees, or still water: which wall
is which is read off the resource pack's blockstates, from the model each one
draws and how far it is turned. Four layouts are drawn by hand:

- a split, water fed in flowing north that leaves both north and west,
  'split_n_nw'
- a merge, water fed in flowing north and flowing east that leaves north,
  'merge_ne_n'
- a split to both sides, water fed in flowing north that leaves both east and
  west, 'split_n_ew'
- a merge from both sides, water fed in flowing east and flowing west that
  leaves north, 'merge_ew_n'

Every other split and merge is one of those turned a quarter at a time,
mirrored east to west, or both: eight each of the first two, and four each of
the last two, which are their own mirror images. Turning or mirroring a piece
turns or mirrors each wall's flow with it, so each takes the wall of its new
direction rather than keeping its own. A split is named for the way its water
is fed and the ways it leaves, 'split_<fed>_<leaves>', and a merge for the ways
it is fed and the way it leaves, 'merge_<fed>_<leaves>', the ways in the order
north, east, south, west.

A layout gives the walls of the tile itself and of the edges of the tiles
beside it that it reaches into, by blocks from the tile's northwestern block.
The tile's own walls are saved as the piece, and the walls on each side it is
fed from or leaves by as a part of their own, '<piece>_<side>', the side the
way from the tile to that tile beside it, empty where the layout sets nothing
there, so a side can be left out where the river beside it does not run the
way the piece expects. Each is saved five blocks by five and one high, from a
block west and a block north of the tile, holding only the walls it sets, so
every one of them is placed a block west, a block north and a block up from
the tile's marker, two below the ground, onto the water's surface.

Run from the repository root: py -3 utils/generate_river_junctions.py
"""
import gzip
import json
import struct
import sys
from pathlib import Path

import worldread

ROOT = Path(__file__).resolve().parent.parent
BLOCKSTATES = ROOT / "resourcepack/assets/minecraft/blockstates"
RIVER = ROOT / "datapack/data/derailed/structure/river"

POINTS = ["n", "nne", "ne", "ene", "e", "ese", "se", "sse",
          "s", "ssw", "sw", "wsw", "w", "wnw", "nw", "nnw"]

STILL_MODEL = "derailed:block/fake_water"

# The way each flow model's water runs unturned, in steps of 22.5 degrees from
#  north
FLOW_MODELS = {
    "derailed:block/fake_water_flow": 8,
    "derailed:block/fake_water_flow_diagonal": 6,
    "derailed:block/fake_water_flow_semi_diagonal1": 7,
    "derailed:block/fake_water_flow_semi_diagonal2": 9,
}

WALL_STATE = {"east": "none", "north": "none", "south": "none", "up": "false",
              "waterlogged": "true", "west": "none"}

SPLIT = {
    (-1, 0): "wnw", (0, 0): "nw", (1, 0): "n", (2, 0): "n",
    (-1, 1): "wnw", (0, 1): "nw", (1, 1): "nnw", (2, 1): "n",
    (-1, 2): "wnw", (0, 2): "nw", (1, 2): "nnw", (2, 2): "n",
    (0, 3): "nnw",
}

MERGE = {
    (0, -1): "nne",
    (-1, 0): "ene", (0, 0): "ne", (1, 0): "nne", (2, 0): "n",
    (-1, 1): "ene", (0, 1): "ne", (1, 1): "nne", (2, 1): "n",
    (-1, 2): "ene", (0, 2): "ne", (1, 2): "n", (2, 2): "n",
}

SPLIT_SIDES = {
    (0, 0): "wnw", (1, 0): "still", (2, 0): "ene",
    (0, 1): "wnw", (1, 1): "n", (2, 1): "ene",
    (-1, 2): "wnw", (0, 2): "nw", (1, 2): "n", (2, 2): "ne", (3, 2): "ene",
    (0, 3): "nnw", (2, 3): "nne",
}

MERGE_SIDES = {
    (0, -1): "nne", (2, -1): "nnw",
    (-1, 0): "ene", (0, 0): "ne", (1, 0): "n", (2, 0): "nw", (3, 0): "wnw",
    (-1, 1): "ene", (0, 1): "ne", (1, 1): "n", (2, 1): "nw", (3, 1): "wnw",
    (0, 2): "ene", (1, 2): "n", (2, 2): "wnw",
}

WAYS = "nesw"


def walls_by_flow():
    walls = {}
    for path in sorted(BLOCKSTATES.glob("*_wall.json")):
        for part in json.loads(path.read_text())["multipart"]:
            model = part["apply"]["model"]
            if model in FLOW_MODELS:
                step = (FLOW_MODELS[model] + part["apply"].get("y", 0) // 22.5) % 16
                walls[POINTS[int(step)]] = "minecraft:" + path.stem
            elif model == STILL_MODEL:
                walls["still"] = "minecraft:" + path.stem
    if sorted(walls) != sorted(POINTS + ["still"]):
        sys.exit("the walls do not draw one each of the sixteen flows and still water")
    return walls


def turn_point(p, steps):
    return p if p == "still" else POINTS[(POINTS.index(p) + steps) % 16]


def turn(layout, ways):
    """A quarter turn clockwise about the tile's middle block"""
    out = {(1 - (z - 1), 1 + (x - 1)): turn_point(p, 4) for (x, z), p in layout.items()}
    return out, ["".join(WAYS[(WAYS.index(c) + 1) % 4] for c in w) for w in ways]


def mirror(layout, ways):
    """Mirrored east to west about the tile's middle block"""
    out = {(2 - x, z): p if p == "still" else POINTS[(16 - POINTS.index(p)) % 16]
           for (x, z), p in layout.items()}
    swap = {"e": "w", "w": "e", "n": "n", "s": "s"}
    return out, ["".join(swap[c] for c in w) for w in ways]


def sort_ways(w):
    return "".join(sorted(w, key=WAYS.index))


def nbt(value):
    if isinstance(value, int):
        return 3, struct.pack(">i", value)
    if isinstance(value, str):
        b = value.encode("utf-8")
        return 8, struct.pack(">H", len(b)) + b
    if isinstance(value, dict):
        out = b""
        for k, v in value.items():
            tag, payload = nbt(v)
            out += bytes([tag]) + nbt(k)[1] + payload
        return 10, out + b"\x00"
    if isinstance(value, list):
        if not value:
            return 9, b"\x00" + struct.pack(">i", 0)
        items = [nbt(v) for v in value]
        return 9, bytes([items[0][0]]) + struct.pack(">i", len(items)) + b"".join(p for _, p in items)
    raise TypeError(type(value))


def side_of(x, z):
    """The side of the tile a block of a layout lies on, or None on the tile"""
    if z < 0:
        return "n"
    if z > 2:
        return "s"
    if x < 0:
        return "w"
    if x > 2:
        return "e"
    return None


def write_parts(name, layout, ways, walls, version):
    """Writes the piece and a part for each side it is fed from or leaves by"""
    back = {"n": "s", "s": "n", "e": "w", "w": "e"}
    fed, leaves = ways
    sides = {back[c] for c in fed} | set(leaves)
    parts = {None: {}}
    parts.update({s: {} for s in sides})
    for pos, p in layout.items():
        side = side_of(*pos)
        if side not in parts:
            sys.exit("%s sets a wall on its %s side, which it neither is fed from nor leaves by" % (name, side))
        parts[side][pos] = p
    for side, cells in parts.items():
        write(name if side is None else "%s_%s" % (name, side), cells, walls, version)


def write(name, layout, walls, version):
    palette = []
    blocks = []
    for (x, z) in sorted(layout):
        wall = walls[layout[(x, z)]]
        if wall not in palette:
            palette.append(wall)
        blocks.append((x + 1, z + 1, palette.index(wall)))
    blocks.sort()
    root = {
        "DataVersion": version,
        "blocks": [{"pos": [x, 0, z], "state": s} for x, z, s in blocks],
        "entities": [],
        "palette": [{"id": w, "properties": dict(WALL_STATE)} for w in palette],
        "size": [5, 1, 5],
    }
    tag, payload = nbt(root)
    raw = bytes([tag]) + nbt("")[1] + payload
    (RIVER / (name + ".nbt")).write_bytes(gzip.compress(raw, mtime=0))


def main():
    walls = walls_by_flow()
    version = worldread.parse_nbt(gzip.decompress((RIVER / "river_n.nbt").read_bytes()))["DataVersion"]
    written = []
    pieces = (
        ("split", SPLIT, ["n", "nw"], True),
        ("merge", MERGE, ["ne", "n"], True),
        ("split", SPLIT_SIDES, ["n", "ew"], False),
        ("merge", MERGE_SIDES, ["ew", "n"], False),
    )
    for kind, layout, ways, mirrored in pieces:
        if not mirrored and mirror(layout, ways)[0] != layout:
            sys.exit("%s_%s is taken to be its own mirror image but is not" % (kind, "_".join(ways)))
        for flip in (False, True) if mirrored else (False,):
            piece, piece_ways = mirror(layout, ways) if flip else (layout, ways)
            for _ in range(4):
                name = "%s_%s" % (kind, "_".join(sort_ways(w) for w in piece_ways))
                write_parts(name, piece, piece_ways, walls, version)
                written.append(name)
                piece, piece_ways = turn(piece, piece_ways)
    if len(set(written)) != len(written):
        sys.exit("two pieces came out with the same name: %s" % written)
    print("wrote %d: %s" % (len(written), " ".join(written)))


if __name__ == "__main__":
    main()
