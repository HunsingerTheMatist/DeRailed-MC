"""Reads blocks, entities and scores straight out of a saved world.

The game only writes chunks to disk on autosave or on quit, so run /save-all in
game before reading, or what comes back will be the state at the last save.

    py utils/worldread.py blocks 1048 0 1053 15
    py utils/worldread.py blocks 1048 0 1053 15 --y 2
    py utils/worldread.py entities 1000 0 1143 15
    py utils/worldread.py scores gen
"""

import argparse
import gzip
import os
import struct
import sys
import zlib

SAVES = os.path.join(os.environ.get("APPDATA", ""), ".minecraft", "saves")

END, BYTE, SHORT, INT, LONG, FLOAT, DOUBLE, BYTE_ARRAY, STRING, LIST, COMPOUND, INT_ARRAY, LONG_ARRAY = range(13)


class Reader:
    def __init__(self, data):
        self.d = data
        self.i = 0

    def take(self, n):
        v = self.d[self.i:self.i + n]
        self.i += n
        return v

    def num(self, fmt, n):
        return struct.unpack(">" + fmt, self.take(n))[0]

    def string(self):
        return self.take(self.num("H", 2)).decode("utf-8", "replace")

    def payload(self, tag):
        if tag == BYTE:
            return self.num("b", 1)
        if tag == SHORT:
            return self.num("h", 2)
        if tag == INT:
            return self.num("i", 4)
        if tag == LONG:
            return self.num("q", 8)
        if tag == FLOAT:
            return self.num("f", 4)
        if tag == DOUBLE:
            return self.num("d", 8)
        if tag == BYTE_ARRAY:
            return self.take(self.num("i", 4))
        if tag == STRING:
            return self.string()
        if tag == LIST:
            inner = self.num("b", 1)
            return [self.payload(inner) for _ in range(max(0, self.num("i", 4)))]
        if tag == COMPOUND:
            out = {}
            while True:
                t = self.num("b", 1)
                if t == END:
                    return out
                # The name has to be read into its own name first: Python
                #  evaluates the right of an assignment before the left, so
                #  reading both inline takes the payload where the name is
                key = self.string()
                out[key] = self.payload(t)
        if tag == INT_ARRAY:
            return [self.num("i", 4) for _ in range(self.num("i", 4))]
        if tag == LONG_ARRAY:
            return [self.num("q", 8) for _ in range(self.num("i", 4))]
        raise ValueError("unknown tag %d at %d" % (tag, self.i))


def parse_nbt(raw):
    r = Reader(raw)
    tag = r.num("b", 1)
    if tag == END:
        return {}
    r.string()
    return r.payload(tag)


def decompress(kind, blob):
    if kind == 1:
        return gzip.decompress(blob)
    if kind == 2:
        return zlib.decompress(blob)
    if kind == 3:
        return blob
    raise ValueError("compression %d is not one this reads" % kind)


def read_region(path):
    """Yields (chunk_x, chunk_z, nbt) for every chunk stored in a region file."""
    if not os.path.exists(path):
        return
    with open(path, "rb") as f:
        header = f.read(4096)
        if len(header) < 4096:
            return
        for i in range(1024):
            off = int.from_bytes(header[i * 4:i * 4 + 3], "big")
            if off == 0:
                continue
            f.seek(off * 4096)
            size = int.from_bytes(f.read(4), "big")
            kind = f.read(1)[0]
            if size <= 1:
                continue
            try:
                nbt = parse_nbt(decompress(kind & 0x7F, f.read(size - 1)))
            except Exception as e:
                print("  (chunk %d unreadable: %s)" % (i, e), file=sys.stderr)
                continue
            yield nbt.get("xPos", 0), nbt.get("zPos", 0), nbt


def palette_name(entry):
    """A palette entry holds its name under '' when it has no properties set and
    under 'id' when it has, and is a bare string in older saves."""
    if isinstance(entry, str):
        name = entry
    else:
        name = entry.get("id") or entry.get("") or "?"
    return name.replace("minecraft:", "")


def section_blocks(section):
    """Returns a function from (x, y, z) inside the section to a block name."""
    states = section.get("block_states") or {}
    palette = states.get("palette") or []
    names = [palette_name(p) for p in palette]
    if not names:
        return lambda x, y, z: "air"
    data = states.get("data")
    if not data:
        return lambda x, y, z: names[0]
    bits = max(4, (len(names) - 1).bit_length())
    per_long = 64 // bits
    mask = (1 << bits) - 1

    def at(x, y, z):
        idx = y * 256 + z * 16 + x
        word, slot = divmod(idx, per_long)
        if word >= len(data):
            return "?"
        return names[(data[word] >> (slot * bits)) & mask]

    return at


def load_blocks(dim, cx1, cz1, cx2, cz2):
    """Builds {(x, y, z): name} for the chunks covering a range."""
    out = {}
    regions = {(cx >> 5, cz >> 5) for cx in range(cx1, cx2 + 1) for cz in range(cz1, cz2 + 1)}
    for rx, rz in sorted(regions):
        path = os.path.join(dim, "region", "r.%d.%d.mca" % (rx, rz))
        for cx, cz, nbt in read_region(path):
            if not (cx1 <= cx <= cx2 and cz1 <= cz <= cz2):
                continue
            for section in nbt.get("sections") or []:
                sy = section.get("Y", 0)
                at = section_blocks(section)
                for y in range(16):
                    for z in range(16):
                        for x in range(16):
                            name = at(x, y, z)
                            if name != "air":
                                out[(cx * 16 + x, sy * 16 + y, cz * 16 + z)] = name
    return out


SHORT_NAMES = {
    "lime_concrete": "gnd", "brown_concrete": "wood", "light_gray_concrete": "iron",
    "blue_concrete": "watr", "gray_concrete": "rock", "black_concrete": "----",
    "light_blue_concrete": "RIVR", "magenta_glazed_terracotta": "RIVR",
}


FAMILIES = (("_glazed_terracotta", "G"), ("_terracotta", "T"),
            ("_concrete", "C"), ("_stained_glass", "g"))


def short(name):
    """Three letters of the colour and one for the family, so that a glazed
    terracotta is never mistaken for the plain one of the same colour."""
    if name in SHORT_NAMES:
        return SHORT_NAMES[name]
    for suffix, tag in FAMILIES:
        if name.endswith(suffix):
            # 'light_' shortens to 'l' so that light_blue and light_gray do not
            #  both come out as 'lig'
            colour = name[:-len(suffix)].replace("light_", "l")
            return colour[:3] + tag
    return name[:4]


def cmd_blocks(args, dim):
    x1, x2 = sorted((args.a, args.c))
    z1, z2 = sorted((args.b, args.d))
    blocks = load_blocks(dim, x1 >> 4, z1 >> 4, x2 >> 4, z2 >> 4)
    print("x %d..%d  z %d..%d  y %d" % (x1, x2, z1, z2, args.y))
    print("      " + " ".join("%4d" % x for x in range(x1, x2 + 1)))
    for z in range(z1, z2 + 1):
        row = [short(blocks.get((x, args.y, z), "air")) for x in range(x1, x2 + 1)]
        print("z%4d " % z + " ".join("%4s" % c for c in row))


def uuid_text(ints):
    """The UUID an entity is filed under, from the four ints it is stored as."""
    if not ints or len(ints) != 4:
        return None
    n = 0
    for part in ints:
        n = (n << 32) | (part & 0xFFFFFFFF)
    h = "%032x" % n
    return "%s-%s-%s-%s-%s" % (h[0:8], h[8:12], h[12:16], h[16:20], h[20:32])


def load_scores(world):
    """Builds {holder: {objective: score}} from the saved scoreboard."""
    path = os.path.join(world, "data", "minecraft", "scoreboard.dat")
    if not os.path.exists(path):
        path = os.path.join(world, "data", "scoreboard.dat")
    if not os.path.exists(path):
        return {}
    nbt = parse_nbt(gzip.decompress(open(path, "rb").read()))
    out = {}
    for r in (nbt.get("data") or {}).get("PlayerScores") or []:
        out.setdefault(r.get("Name", ""), {})[r.get("Objective", "")] = r.get("Score", 0)
    return out


def cmd_entities(args, dim):
    x1, x2 = sorted((args.a, args.c))
    z1, z2 = sorted((args.b, args.d))
    found = []
    regions = {(cx >> 5, cz >> 5) for cx in range(x1 >> 4, (x2 >> 4) + 1) for cz in range(z1 >> 4, (z2 >> 4) + 1)}
    for rx, rz in sorted(regions):
        path = os.path.join(dim, "entities", "r.%d.%d.mca" % (rx, rz))
        for _, _, nbt in read_region(path):
            for e in nbt.get("Entities") or []:
                pos = e.get("Pos") or [0, 0, 0]
                if x1 <= pos[0] <= x2 and z1 <= pos[2] <= z2:
                    found.append((pos, e.get("id", "?").replace("minecraft:", ""),
                                  e.get("Tags") or [], uuid_text(e.get("UUID"))))
    found.sort(key=lambda f: (f[0][0], f[0][2]))
    scores = load_scores(args.world_path)
    print("%d entities in x %d..%d z %d..%d" % (len(found), x1, x2, z1, z2))
    for pos, kind, tags, uid in found:
        got = scores.get(uid or "", {})
        held = " ".join("%s=%d" % (k, v) for k, v in sorted(got.items()))
        print("  %8.1f %5.1f %8.1f  %-10s %-28s %s" % (pos[0], pos[1], pos[2], kind, ",".join(tags), held))


def cmd_scores(args, world):
    # Newer saves file it under the namespace, older ones directly under data
    path = os.path.join(world, "data", "minecraft", "scoreboard.dat")
    if not os.path.exists(path):
        path = os.path.join(world, "data", "scoreboard.dat")
    nbt = parse_nbt(gzip.decompress(open(path, "rb").read()))
    rows = (nbt.get("data") or {}).get("PlayerScores") or []
    hits = [r for r in rows if args.pattern in r.get("Name", "") or args.pattern in r.get("Objective", "")]
    hits.sort(key=lambda r: r.get("Name", ""))
    print("%d scores matching %r" % (len(hits), args.pattern))
    for r in hits:
        print("  %-24s %-10s %d" % (r.get("Name", "?"), r.get("Objective", "?"), r.get("Score", 0)))


def cmd_storage(args, world):
    """Prints the command storage a namespace holds."""
    path = os.path.join(world, "data", args.dim.split("/")[0], "command_storage.dat")
    nbt = parse_nbt(gzip.decompress(open(path, "rb").read()))
    contents = (nbt.get("data") or {}).get("contents") or nbt.get("contents") or nbt
    for name, held in sorted(contents.items()):
        if args.pattern and args.pattern not in name:
            continue
        print("%s:" % name)
        for key, value in sorted((held or {}).items()):
            text = repr(value)
            print("  %-14s %s" % (key, text[:200] + ("..." if len(text) > 200 else "")))


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("command", choices=["blocks", "entities", "scores", "storage"])
    p.add_argument("a", nargs="?", type=int)
    p.add_argument("b", nargs="?", type=int)
    p.add_argument("c", nargs="?", type=int)
    p.add_argument("d", nargs="?", type=int)
    p.add_argument("--y", type=int, default=15, help="the layer to read: 15 the terrain, 9 the river, 5 the kinds, 0 the regions as they grew")
    p.add_argument("--world", default="DeRailed Testing")
    p.add_argument("--dim", default="derailed/game")
    p.add_argument("--pattern", default="", help="for scores, the text to match")
    args = p.parse_args()

    world = os.path.join(SAVES, args.world)
    args.world_path = world
    dim = os.path.join(world, "dimensions", *args.dim.split("/"))
    if args.command == "storage":
        cmd_storage(args, world)
    elif args.command == "scores":
        args.pattern = args.pattern or (str(args.a) if args.a is not None else "")
        cmd_scores(args, world)
    elif args.command == "blocks":
        cmd_blocks(args, dim)
    else:
        cmd_entities(args, dim)


if __name__ == "__main__":
    main()
