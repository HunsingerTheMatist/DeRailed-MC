"""
Generates the font-based HUD test drawn like map 7: the map's 128 by 128
pixels in the vanilla map's paper border, in the screen's bottom-left corner,
through the action bar, which is the one line of text placed from the bottom of
the screen; one font for each scale in SCALES, GUI pixels to a map pixel, and
each detail its players' GUI scales want, all with the same characters, so the
datapack's tables serve every one of them

The strips above and below the board are the map's own pixels; the board is
built from the map's 5 by 5 tiles, each glyph a tile and the five rows above it
that it reaches into; the players' markers are the player icon vanilla maps had
before 26.3, 8 map pixels across, turned 16 ways

Placement: the action bar's line is 72 GUI pixels above the screen's bottom
and a glyph's top is 7 less its ascent below the line; an ascent and a height
are whole GUI pixels, and an ascent may not be more than its glyph's height,
so glyphs high up carry clear rows below them, and a glyph that would start on
a half pixel carries a clear row above it instead

Usage:
  py -3 generate_hud.py

writes resourcepack/assets/derailed/font/hud_<scale>_<detail>.json, their
textures under resourcepack/assets/derailed/textures/font/hud_<scale>/, and
datapack/data/derailed/function/dev/hud/tables.mcfunction
"""
import gzip
import json
import math
import shutil
import zipfile
from fractions import Fraction
from pathlib import Path

import _png
import worldread

SCRIPT_DIR = Path(__file__).resolve().parent
REPO = SCRIPT_DIR.parent
RP = REPO / "resourcepack" / "assets"
FUNC = REPO / "datapack" / "data" / "derailed" / "function" / "dev" / "hud"
MINECRAFT = Path.home() / "AppData" / "Roaming" / ".minecraft"
MAP = MINECRAFT / "saves" / "DeRailed Testing" / "data" / "minecraft" / "maps" / "7.dat"
# The jar the paper border is read from, and the one with the player icon
#  vanilla maps had before 26.3
JAR = MINECRAFT / "versions" / "26.3" / "26.3.jar"
ICON_JAR = MINECRAFT / "versions" / "26.2" / "26.2.jar"

SCALES = {"1": Fraction(1), "2": Fraction(2), "3": Fraction(3)}
GUI_SCALES = 6      # GUI scales a player may give, 1 up
FONT_PAGE = 256     # texture pixels a glyph may be tall
MARGIN = 4          # GUI pixels from the border's foot to the screen's bottom
BORDER = 7          # map pixels of paper round the map, as the vanilla map has
TOP_ROWS = 24       # map rows above the board
BOARD_ROWS = 16
VARIANTS = 24       # entries in each kind's list of tile variants
ARROW = 8           # map pixels across a player's icon
ROTATIONS = 16
STEPS_ACROSS = 256  # half map pixels across the board
STEPS_DOWN = 160    # and down it

# Codepoints, the same in every scale's font
TOP, BOTTOM = 0xE000, 0xE001
BACK_STRIP = 0xE002     # back over a strip
SPACER = 0xE003         # back over the space after each tile
BACK_ROW = 0xE004       # back over a row of the board
FRAME = 0xE005          # the paper border
BACK_FRAME = 0xE006     # back over it and on to the map's left edge
OUT = 0xE007            # back from the map's left edge to the border's
LEAD = 0xE010           # + k: back 2 ** k pixels
TILES = 0xE100          # + row * glyphs + glyph
MARKS = 0xEA00          # + half map pixel row * 16 + rotation
FWD, BACKS = 0xF400, 0xF500  # + half map pixels across


def write_text(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="\r\n", encoding="utf-8") as f:
        f.write(text)


def clear(w, h):
    return [(0, 0, 0, 0)] * (w * h)


# The map's colours: each map colour's base, as the game's MapColor has them,
#  and the four shades a map pixel takes of it
BASE_COLORS = {
    0: 0x000000, 1: 0x7FB238, 2: 0xF7E9A3, 3: 0xC7C7C7, 4: 0xFF0000, 5: 0xA0A0FF,
    6: 0xA7A7A7, 7: 0x007C00, 8: 0xFFFFFF, 9: 0xA4A8B8, 10: 0x976D4D, 11: 0x707070,
    12: 0x4040FF, 13: 0x8F7748, 14: 0xFFFCF5, 15: 0xD87F33, 16: 0xB24CD8, 17: 0x6699D8,
    18: 0xE5E533, 19: 0x7FCC19, 20: 0xF27FA5, 21: 0x4C4C4C, 22: 0x999999, 23: 0x4C7F99,
    24: 0x7F3FB2, 25: 0x334CB2, 26: 0x664C33, 27: 0x667F33, 28: 0x993333, 29: 0x191919,
    30: 0xFAEE4D, 31: 0x5CDBD5, 32: 0x4A80FF, 33: 0x00D93A, 34: 0x815631, 35: 0x700200,
    36: 0xD1B1A1, 37: 0x9F5224, 38: 0x95576C, 39: 0x706C8A, 40: 0xBA8524, 41: 0x677535,
    42: 0xA04D4E, 43: 0x392923, 44: 0x876B62, 45: 0x575C5C, 46: 0x7A4958, 47: 0x4C3E5C,
    48: 0x4C3223, 49: 0x4C522A, 50: 0x8E3C2E, 51: 0x251610, 52: 0xBD3031, 53: 0x943F61,
    54: 0x5C191D, 55: 0x167E86, 56: 0x3A8E8C, 57: 0x562C3E, 58: 0x14B485, 59: 0x646464,
    60: 0xD8AF93, 61: 0x7FA796,
}
MUL = [180, 220, 255, 135]


def jar_png(jar, path):
    with zipfile.ZipFile(jar) as z:
        return _png.read(z.read(path))


colors = worldread.parse_nbt(gzip.decompress(MAP.read_bytes()))["data"]["colors"]
def px(x, y):
    b = colors[y * 128 + x] & 0xFF
    if b < 4:
        return (0, 0, 0, 0)
    c, m = BASE_COLORS[b >> 2], MUL[b & 3]
    return ((c >> 16 & 255) * m // 255, (c >> 8 & 255) * m // 255, (c & 255) * m // 255, 255)


# The board's tiles, read off the map
GREEN = px(0, 60)
def tile(tx, ty):
    return tuple(px(tx * 5 + i, TOP_ROWS + ty * 5 + j) for j in range(5) for i in range(5))

seen = {}
for ty in range(BOARD_ROWS):
    for tx in range(25):
        seen.setdefault(tile(tx, ty), (tx, ty))

plain, rock, water = tile(2, 0), tile(18, 0), tile(23, 4)
PLANT, PODZOL = tile(0, 0)[2], tile(0, 0)[22]
tufts, trees, irons, ducks = [], [], [], []
for t in seen:
    s = set(t)
    if t in (plain, rock, water):
        continue
    if s == {GREEN, PLANT} and t.count(PLANT) <= 3:
        tufts.append(t)
    elif s == {GREEN, PLANT, PODZOL} and t.count(PLANT) >= 5 and t[22] == PODZOL and PODZOL not in t[:5]:
        # A whole tree: trunk at the bottom middle, nothing of it from above
        trees.append(t)
    elif GREEN not in s and len(s) == 2 and water[0] not in s:
        irons.append(t)
    elif water[0] in s and GREEN not in s and len(s) == 3:
        ducks.append(t)
for group in (tufts, trees, irons):
    group.sort(key=lambda t: seen[t])
station = [tile(3, 7), tile(4, 7)]
station_over = [tile(3, 6), tile(4, 6)]

# Every glyph: the tile, and what it draws over the tile above
glyphs = []
def glyph(body, over=None):
    glyphs.append((body, over))
    return len(glyphs) - 1

g_plain = glyph(plain)
g_tufts = [glyph(t) for t in tufts[:VARIANTS // 2]]
g_trees = [glyph(t) for t in trees]
g_irons = [glyph(t) for t in irons]
g_rock = glyph(rock)
g_water = glyph(water)
g_ducks = [glyph(t) for t in ducks]
g_station = [glyph(station[i], tuple(c if c != GREEN else (0, 0, 0, 0) for c in station_over[i])) for i in range(2)]
FULL = len(glyphs)
NG = FULL * 2
assert TILES + BOARD_ROWS * NG <= MARKS


def fill(items, weights):
    out = []
    for item, w in zip(items, weights):
        out += [item] * w
    out = (out * VARIANTS)[:VARIANTS]
    assert len(out) == VARIANTS
    return out

# Each kind's variants, 'VARIANTS' long, weighted the way the map shows them
kinds = [
    fill([g_plain] + g_tufts, [VARIANTS - len(g_tufts)] + [1] * len(g_tufts)),
    fill(g_trees, [1] * len(g_trees)),
    fill(g_irons, [VARIANTS - 3 * (len(g_irons) - 1)] + [3] * (len(g_irons) - 1)),
    [g_rock] * VARIANTS,
    fill([g_water] + g_ducks, [VARIANTS - len(g_ducks)] + [1] * len(g_ducks)),
    fill([g_water] + g_ducks, [VARIANTS - len(g_ducks)] + [1] * len(g_ducks)),
    [g_station[0]] * VARIANTS,
    [g_station[1]] * VARIANTS,
]

# Each glyph's cell, 5 wide: its reach over the tile above, then the tile; the
#  cut copies keep the first three columns
tile_cells = []
for body, over in glyphs:
    cell = clear(5, 10)
    for j in range(5):
        for i in range(5):
            if over is not None:
                cell[j * 5 + i] = over[j * 5 + i]
            cell[(5 + j) * 5 + i] = body[j * 5 + i]
    tile_cells.append(cell)
tile_cells += [[p if (k % 5) < 3 else (0, 0, 0, 0) for k, p in enumerate(c)] for c in list(tile_cells)]


PLAYER = jar_png(ICON_JAR, "assets/minecraft/textures/map/decorations/player.png")


def arrow(rotation, d):
    """The player icon vanilla maps had before 26.3, turned to bearing
    rotation * 22.5, 0 up, the way a map turns its icons: each pixel of the
    drawing takes the icon's pixel under it, turned back; d texture pixels to
    a map pixel"""
    a = math.radians(rotation * 360 / ROTATIONS)
    iw, ih, icon = PLAYER
    n = ARROW * d
    cell = clear(n, n)
    for y in range(n):
        for x in range(n):
            dx, dy = (x + 0.5) / d - ARROW / 2, (y + 0.5) / d - ARROW / 2
            rx = dx * math.cos(a) + dy * math.sin(a) + iw / 2
            ry = -dx * math.sin(a) + dy * math.cos(a) + ih / 2
            if 0 <= rx < iw and 0 <= ry < ih:
                cell[y * n + x] = icon[int(ry) * iw + int(rx)]
    return cell


def sheet(cells, w, h, top, rows, mark_width=False):
    """Lays cells w wide and h tall side by side, each with 'top' clear rows
    above it and clear rows below down to 'rows' in all; with 'mark_width' a
    nearly clear pixel at the right of its last row keeps every cell as wide"""
    out = clear(w * len(cells), rows)
    for n, c in enumerate(cells):
        for j in range(h):
            for i in range(w):
                out[(top + j) * w * len(cells) + n * w + i] = c[j * w + i]
        if mark_width:
            out[(rows - 1) * w * len(cells) + n * w + w - 1] = (0, 0, 0, 1)
    return w * len(cells), rows, out


def strip(y0, rows):
    return [px(x, y0 + y) for y in range(rows) for x in range(128)]


def tall(s, top, content, ascent):
    """The rows a cell needs: its clear top, its content, and enough below that
    its height in GUI pixels is whole and at least its ascent"""
    rows = top + content
    while rows * s < ascent or (rows * s).denominator != 1:
        rows += 1
    return rows


def advance(s, texels):
    """A bitmap glyph's advance: its width in GUI pixels rounded, and one"""
    return int(0.5 + float(texels * s)) + 1


def lift(s, y):
    """Clear rows above a glyph whose top falls at y, and its top with them"""
    top = 0
    while (y - top * s).denominator != 1:
        top += 1
    return top, int(y - top * s)


# Background pixels the paper border reaches past the map, a whole number
def border(s):
    return math.ceil(BORDER * s)


bg_w, bg_h, bg = jar_png(JAR, "assets/minecraft/textures/map/map_background.png")
for old in (RP / "derailed" / "font").glob("hud_*.json"):
    old.unlink()
fonts, written = {}, set()
for name, s in SCALES.items():
    tex = "derailed:font/hud_%s/" % name
    out = RP / "derailed" / "textures" / "font" / ("hud_" + name)
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    b = border(s)
    hud = 128 * s
    # A glyph whose top is y GUI pixels down the map has ascent a0 - y
    a0 = MARGIN + b + hud - 65
    assert a0.denominator == 1
    a0 = int(a0)

    providers = []

    def bitmap(file, rows, ascent, chars, texel=s):
        height = rows * texel
        assert height.denominator == 1 and ascent <= height, (file, rows, ascent)
        providers.append({"type": "bitmap", "file": tex + file, "height": int(height),
                          "ascent": ascent, "chars": chars})

    # The paper border, its texture stretched over the map and its border
    frame_h = int(hud) + 2 * b
    providers.append({"type": "bitmap", "file": "minecraft:map/map_background.png", "height": frame_h,
                      "ascent": a0 + b, "chars": [chr(FRAME)]})
    assert a0 + b <= frame_h
    frame_adv = int(0.5 + frame_h * bg_w / bg_h) + 1

    # The strips
    rows = tall(s, 0, TOP_ROWS, a0)
    _png.write(out / "top.png", 128, rows, strip(0, TOP_ROWS) + clear(128, rows - TOP_ROWS))
    bitmap("top.png", rows, a0, [chr(TOP)])
    y = (TOP_ROWS + BOARD_ROWS * 5) * s
    rows = tall(s, 0, 24, a0 - int(y))
    _png.write(out / "bottom.png", 128, rows, strip(104, 24) + clear(128, rows - 24))
    bitmap("bottom.png", rows, a0 - int(y), [chr(BOTTOM)])

    # The board's rows, each on a sheet lifted by the clear rows its top needs,
    #  one sheet for each lift, as tall as the highest row on it needs
    lifted = [lift(s, (TOP_ROWS + 5 * r - 5) * s) for r in range(BOARD_ROWS)]
    tile_rows = {}
    for top, y_top in lifted:
        tile_rows[top] = max(tile_rows.get(top, 0), tall(s, top, 10, a0 - y_top))
    for top, rows in tile_rows.items():
        w, h, px_ = sheet(tile_cells, 5, 10, top, rows)
        _png.write(out / ("tiles_%d.png" % top), w, h, px_)
    for r, (top, y_top) in enumerate(lifted):
        bitmap("tiles_%d.png" % top, tile_rows[top], a0 - y_top,
               ["".join(chr(TILES + r * NG + g) for g in range(NG))])

    spacer = 5 * s - advance(s, 5)
    assert spacer == 3 * s - advance(s, 3)
    arrow_adv = advance(s, ARROW)
    advances = {
        chr(BACK_STRIP): -advance(s, 128),
        chr(SPACER): float(spacer),
        chr(BACK_ROW): -float(hud),
        chr(BACK_FRAME): -(frame_adv - b),
        chr(OUT): -b,
    }
    for k in range(12):
        advances[chr(LEAD + k)] = -(2 ** k)
    # The arrows go across to the whole GUI pixel nearest their half map pixel,
    #  and the same down, so their texture lies on the screen's pixels
    half = Fraction(ARROW, 2) * s
    for i in range(STEPS_ACROSS):
        left = math.floor(Fraction(i, 2) * s + Fraction(1, 2)) - half
        advances[chr(FWD + i)] = float(left)
        advances[chr(BACKS + i)] = float(-left - arrow_adv)
    tops = [math.floor((TOP_ROWS + Fraction(v, 2)) * s + Fraction(1, 2) - half) for v in range(STEPS_DOWN)]

    # One font for each detail a GUI scale wants at this scale: the most
    #  texture pixels to a map pixel that divide its screen pixels to a map
    #  pixel evenly and fit a font page, so each texture pixel is whole screen
    #  pixels
    def arrow_rows(d):
        return tall(s / d, 0, ARROW * d, a0 - tops[0])
    for gui in range(1, GUI_SCALES + 1):
        per = int(gui * s)
        d = max(k for k in range(1, per + 1) if per % k == 0 and arrow_rows(k) <= FONT_PAGE)
        fonts[(name, gui)] = "derailed:hud_%s_%d" % (name, d)
        if (name, d) in written:
            continue
        written.add((name, d))
        rows = arrow_rows(d)
        w, h, px_ = sheet([arrow(r, d) for r in range(ROTATIONS)], ARROW * d, ARROW * d, 0, rows, mark_width=True)
        _png.write(out / ("arrow_%d.png" % d), w, h, px_)
        marks = []
        for v, y in enumerate(tops):
            height = rows * s / d
            assert height.denominator == 1 and a0 - y <= height
            marks.append({"type": "bitmap", "file": tex + "arrow_%d.png" % d, "height": int(height),
                          "ascent": a0 - y, "chars": ["".join(chr(MARKS + v * 16 + k) for k in range(ROTATIONS))]})
        font = {"providers": providers + marks + [{"type": "space", "advances": advances}]}
        write_text(RP / "derailed" / "font" / ("hud_%s_%d.json" % (name, d)), json.dumps(font, indent=2) + "\n")
    print(name, "border", b, "a0", a0, "details", sorted(d for n, d in written if n == name))


# The datapack's tables, the same for every scale
def esc(cp):
    return "\\u%04X" % cp

tiles = []
for cut in (0, 1):
    for r in range(BOARD_ROWS):
        for k in range(len(kinds)):
            for v in range(VARIANTS):
                tiles.append(esc(TILES + r * NG + kinds[k][v] + cut * FULL) + esc(SPACER))
lines = [
    "",
    "# The characters the HUD test is drawn with, generated by",
    "#  'utils/generate_hud.py', the same in every scale's font: 'tiles' by whether",
    "#  the tile is cut, its row, its kind and its variant, each with the space after",
    "#  it taken back; 'mark' by half map pixel row times sixteen plus rotation;",
    "#  'fwd' and 'back' by half map pixels across; 'fonts' by scale less one times",
    "#  '$HudGuiScales' plus GUI scale less one",
    "",
    "scoreboard players set $HudVariants dr_const %d" % VARIANTS,
    "scoreboard players set $HudKinds dr_const %d" % len(kinds),
    "scoreboard players set $HudPixel dr_const %d" % (3000 // 10),
    "scoreboard players set $HudBoardWidth dr_const %d" % STEPS_ACROSS,
    "scoreboard players set $HudBoardHeight dr_const %d" % STEPS_DOWN,
    "scoreboard players set $HudGuiScales dr_const %d" % GUI_SCALES,
    "data modify storage derailed:hud fonts set value [" + ",".join(
        '"%s"' % fonts[(name, gui)] for name in SCALES for gui in range(1, GUI_SCALES + 1)) + "]",
    "data modify storage derailed:hud tiles set value [" + ",".join('"%s"' % t for t in tiles) + "]",
    "data modify storage derailed:hud mark set value [" + ",".join(
        '{text:"%s"}' % esc(MARKS + v * 16 + k) for v in range(STEPS_DOWN) for k in range(ROTATIONS)) + "]",
    "data modify storage derailed:hud fwd set value [" + ",".join('{text:"%s"}' % esc(FWD + i) for i in range(STEPS_ACROSS)) + "]",
    "data modify storage derailed:hud back set value [" + ",".join('{text:"%s"}' % esc(BACKS + i) for i in range(STEPS_ACROSS)) + "]",
    'data modify storage derailed:hud colors set value ["red","aqua","yellow","light_purple","green","gold"]',
    'data modify storage derailed:hud strips set value {open:"%s%s",close:"%s",top:"%s%s",bottom:"%s%s",row_end:"%s"}' % (
        esc(FRAME), esc(BACK_FRAME), esc(OUT), esc(TOP), esc(BACK_STRIP), esc(BOTTOM), esc(BACK_STRIP), esc(BACK_ROW)),
]
write_text(FUNC / "tables.mcfunction", "\n".join(lines) + "\n")
print("glyphs", NG)
