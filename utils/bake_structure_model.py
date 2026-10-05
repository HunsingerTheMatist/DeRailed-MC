"""
Bakes a saved structure into a single item model, so a whole build can be shown
by one item_display rather than a block display per block.

Every block's model is found the way the game finds it: its blockstate from the
resource pack if the pack has one and from the vanilla jar otherwise, the
variant or the multipart pieces its state selects, and each model's parents and
texture variables walked up to their elements. Each element is turned by its
variant's x and y rotation, moved to the block's place in the structure and
shrunk, and every face that sits against a full opaque block, where the game
would cull it, is left out.

An item model may only reach from -16 to 32 on each axis, three blocks, so the
model is baked smaller than the size asked for and the item_display showing it
is scaled back up: by the first of DISPLAY_SCALES that brings the model inside
those bounds, which the bake prints with the command that summons it. The
model is centred on x and z, with the structure's floor at y 8, the middle of
the item, so the display stands it on the display's own position whatever it
is scaled by.

Parts that move on their own, such as wheels, are baked as models of their own
with --middle, which centres them on the display so they turn about their
middle, and cut out of the model they belong to with --cut, which also prints
where each one lies so its display can be put there.

Usage:
  py -3 bake_structure_model.py datapack/data/derailed/structure/train.nbt --scale 0.3 --name train
      --nudge 0,0,-0.3 --cut datapack/data/derailed/structure/train_big_wheels.nbt
  py -3 bake_structure_model.py datapack/data/derailed/structure/train_big_wheels.nbt --scale 0.3
      --name train_big_wheels --middle --inset mangrove_button=5

writes resourcepack/assets/derailed/models/item/<name>.json and the item
definition resourcepack/assets/derailed/items/<name>.json
"""
import argparse
import gzip
import json
import sys
import zipfile
from pathlib import Path

import _png
import format_models
import worldread

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
RESOURCEPACK = ROOT / "resourcepack"
DEFAULT_JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"

# What the display may be scaled by, smallest first; the model is baked at the
#  inverse share of the size asked for
DISPLAY_SCALES = (2, 2.5, 3, 4, 5, 6, 8)

# What an item model's coordinates may reach
MODEL_MIN = -16
MODEL_MAX = 32

# Blocks that are full cubes but let the faces behind them show, so nothing
#  is culled against them but the same block
SEE_THROUGH = ("glass", "leaves", "ice")

DIRECTIONS = {
    "down": (0, -1, 0), "up": (0, 1, 0),
    "north": (0, 0, -1), "south": (0, 0, 1),
    "west": (-1, 0, 0), "east": (1, 0, 0),
}
DIRECTION_OF = {v: k for k, v in DIRECTIONS.items()}
AXIS_VECTORS = {"x": (1, 0, 0), "y": (0, 1, 0), "z": (0, 0, 1)}


class Assets:
    """Reads blockstates, models and textures from the resource pack first and
    the vanilla jar second, the order the game layers them in"""

    def __init__(self, jar):
        self.jar = zipfile.ZipFile(jar)
        self.cache = {}

    def read(self, path):
        if path in self.cache:
            return self.cache[path]
        local = RESOURCEPACK / path
        data = None
        if local.is_file():
            data = json.loads(local.read_text(encoding="utf-8"))
        else:
            try:
                data = json.loads(self.jar.read(path))
            except KeyError:
                data = None
        self.cache[path] = data
        return data

    def blockstate(self, block_id):
        namespace, _, name = block_id.rpartition(":")
        return self.read("assets/%s/blockstates/%s.json" % (namespace or "minecraft", name))

    def model(self, ref):
        namespace, _, path = ref.rpartition(":")
        return self.read("assets/%s/models/%s.json" % (namespace or "minecraft", path))

    def average_colour(self, ref):
        """A texture's colour averaged over its pixels, as red, green and blue"""
        namespace, _, path = full_ref(ref).rpartition(":")
        inside = "assets/%s/textures/%s.png" % (namespace, path)
        local = RESOURCEPACK / inside
        data = local.read_bytes() if local.is_file() else self.jar.read(inside)
        _, _, pixels = _png.read(data)
        return [sum(p[i] for p in pixels) / len(pixels) for i in range(3)]


def full_ref(ref):
    """'block/stone' as 'minecraft:block/stone'"""
    return ref if ":" in ref else "minecraft:" + ref


def texture_key(value):
    """A texture as a string that can key a map: its full name, or the object
    form written out with its sprite's full name"""
    if isinstance(value, dict):
        value = dict(value, sprite=full_ref(value["sprite"]))
        return json.dumps(value, sort_keys=True)
    return full_ref(value)


def texture_value(key):
    """What a texture key is written as in the model"""
    return json.loads(key) if key.startswith("{") else key


def resolve_model(assets, ref):
    """Walks a model's parents, returning its elements and its texture map with
    every '#variable' followed to the texture it ends at"""
    textures = {}
    elements = None
    seen = set()
    while ref and ref not in seen:
        seen.add(ref)
        model = assets.model(full_ref(ref))
        if model is None:
            raise KeyError("model %s is missing" % ref)
        for key, value in model.get("textures", {}).items():
            textures.setdefault(key, value)
        if elements is None and "elements" in model:
            elements = model["elements"]
        ref = model.get("parent")

    # A texture is a name, or an object naming its sprite along with how it is
    #  drawn, which is kept whole so glass stays translucent
    def follow(value, depth=0):
        while isinstance(value, str) and value.startswith("#") and depth < 16:
            value = textures.get(value[1:], value)
            depth += 1
        return value

    resolved = {k: follow(v) for k, v in textures.items()}
    return elements or [], resolved


def matches(condition, props):
    """Whether a multipart 'when' holds for a block's properties"""
    if "OR" in condition:
        return any(matches(c, props) for c in condition["OR"])
    if "AND" in condition:
        return all(matches(c, props) for c in condition["AND"])
    return all(props.get(k) in str(v).split("|") for k, v in condition.items())


def pick(choice):
    """The first of a weighted list, so a bake comes out the same every time"""
    return choice[0] if isinstance(choice, list) else choice


def select(state_def, props):
    """The model entries a block's state draws: one variant, or every matching
    multipart piece"""
    if "variants" in state_def:
        for key, choice in state_def["variants"].items():
            pairs = [p.split("=", 1) for p in key.split(",") if p]
            if all(props.get(k) == v for k, v in pairs):
                return [pick(choice)]
        return []
    return [pick(part["apply"]) for part in state_def.get("multipart", [])
            if "when" not in part or matches(part["when"], props)]


def rotate_point(p, x_turns, y_turns):
    """Turns a point about the block's centre the way a variant's x then y
    rotation does: x 90 takes up to north, y 90 takes north to east"""
    x, y, z = p[0] - 8, p[1] - 8, p[2] - 8
    for _ in range(x_turns % 4):
        y, z = z, -y
    for _ in range(y_turns % 4):
        x, z = -z, x
    return (x + 8, y + 8, z + 8)


def rotate_vector(v, x_turns, y_turns):
    x, y, z = v
    for _ in range(x_turns % 4):
        y, z = z, -y
    for _ in range(y_turns % 4):
        x, z = -z, x
    return (x, y, z)


def face_vertices(direction, lo, hi):
    """A face's four corners in the order the game gives them their uvs"""
    x0, y0, z0 = lo
    x1, y1, z1 = hi
    return {
        "down": [(x0, y0, z1), (x0, y0, z0), (x1, y0, z0), (x1, y0, z1)],
        "up": [(x0, y1, z0), (x0, y1, z1), (x1, y1, z1), (x1, y1, z0)],
        "north": [(x1, y1, z0), (x1, y0, z0), (x0, y0, z0), (x0, y1, z0)],
        "south": [(x0, y1, z1), (x0, y0, z1), (x1, y0, z1), (x1, y1, z1)],
        "west": [(x0, y1, z0), (x0, y0, z0), (x0, y0, z1), (x0, y1, z1)],
        "east": [(x1, y1, z1), (x1, y0, z1), (x1, y0, z0), (x1, y1, z0)],
    }[direction]


def default_uv(direction, lo, hi):
    """The uv the game gives a face that names none, the element's own shadow
    on that side of the block"""
    x0, y0, z0 = lo
    x1, y1, z1 = hi
    return {
        "down": [x0, 16 - z1, x1, 16 - z0],
        "up": [x0, z0, x1, z1],
        "north": [16 - x1, 16 - y1, 16 - x0, 16 - y0],
        "south": [x0, 16 - y1, x1, 16 - y0],
        "west": [z0, 16 - y1, z1, 16 - y0],
        "east": [16 - z1, 16 - y1, 16 - z0, 16 - y0],
    }[direction]


def corner_uvs(uv, rotation):
    """The uv each of a face's four corners takes, for a face's uv and its
    rotation"""
    u1, v1, u2, v2 = uv
    by_index = [(u1, v1), (u1, v2), (u2, v2), (u2, v1)]
    shift = (rotation // 90) % 4
    return [by_index[(i + shift) % 4] for i in range(4)]


def fit_uv(corners):
    """The uv and rotation that give a face's four corners the uvs asked for"""
    for rotation in (0, 90, 180, 270):
        shift = rotation // 90
        at = {(i + shift) % 4: corners[i] for i in range(4)}
        u1, v1 = at[0]
        u2, v2 = at[2]
        if at[1] == (u1, v2) and at[3] == (u2, v1):
            return [u1, v1, u2, v2], rotation
    return None, 0


def key(p):
    return tuple(round(c, 4) for c in p)


def turn_element(element, x_turns, y_turns, uvlock):
    """An element as its variant turns it: its box, its own rotation's axis and
    origin, and every face moved to the side it now faces with its uv mapped so
    the texture lands on the same corners"""
    lo, hi = element["from"], element["to"]
    corners = [rotate_point((x, y, z), x_turns, y_turns)
               for x in (lo[0], hi[0]) for y in (lo[1], hi[1]) for z in (lo[2], hi[2])]
    new_lo = tuple(min(c[i] for c in corners) for i in range(3))
    new_hi = tuple(max(c[i] for c in corners) for i in range(3))

    faces = {}
    for direction, face in element.get("faces", {}).items():
        new_dir = DIRECTION_OF[rotate_vector(DIRECTIONS[direction], x_turns, y_turns)]
        if uvlock and (x_turns or y_turns):
            uv, rotation = default_uv(new_dir, new_lo, new_hi), 0
        else:
            uv = face.get("uv") or default_uv(direction, lo, hi)
            uvs = corner_uvs(uv, face.get("rotation", 0))
            moved = {key(rotate_point(v, x_turns, y_turns)): uvs[i]
                     for i, v in enumerate(face_vertices(direction, lo, hi))}
            wanted = [moved.get(key(v)) for v in face_vertices(new_dir, new_lo, new_hi)]
            if None in wanted:
                continue
            uv, rotation = fit_uv(wanted)
            if uv is None:
                continue
        cull = face.get("cullface")
        if cull:
            cull = DIRECTION_OF[rotate_vector(DIRECTIONS[cull], x_turns, y_turns)]
        faces[new_dir] = {"uv": uv, "rotation": rotation, "texture": face["texture"], "cullface": cull}

    turned = {"from": new_lo, "to": new_hi, "faces": faces, "shade": element.get("shade", True)}
    spin = element.get("rotation")
    if spin and spin.get("angle", 0):
        axis = rotate_vector(AXIS_VECTORS[spin["axis"]], x_turns, y_turns)
        name = next(a for a, v in AXIS_VECTORS.items() if tuple(abs(c) for c in axis) == v)
        sign = 1 if sum(axis) > 0 else -1
        turned["rotation"] = {
            "origin": rotate_point(spin["origin"], x_turns, y_turns),
            "axis": name,
            "angle": spin["angle"] * sign,
            "rescale": spin.get("rescale", False),
        }
    return turned


def is_full_cube(elements):
    return (len(elements) == 1 and not elements[0].get("rotation", {}).get("angle")
            and list(elements[0]["from"]) == [0, 0, 0] and list(elements[0]["to"]) == [16, 16, 16])


def load_structure(path):
    reader = worldread.Reader(gzip.decompress(Path(path).read_bytes()))
    tag = reader.num("b", 1)
    reader.string()
    return reader.payload(tag)


def bake(structure, assets, scale, warn, nudge=(0, 0, 0), middle=False, insets=None, tints=None):
    palette = structure["palette"]
    size = structure["size"]

    # Every palette state's elements, turned for its variants, and whether it
    #  is a full block that hides what is against it
    states = []
    for entry in palette:
        block_id = full_ref(entry.get("Name") or entry["id"])
        props = {k: str(v) for k, v in entry.get("properties", entry.get("Properties", {})).items()}
        if block_id in ("minecraft:air", "minecraft:structure_void", "minecraft:cave_air"):
            states.append(None)
            continue
        state_def = assets.blockstate(block_id)
        if state_def is None:
            warn("%s has no blockstate" % block_id)
            states.append(None)
            continue
        parts = []
        full = False
        for choice in select(state_def, props):
            try:
                elements, textures = resolve_model(assets, choice["model"])
            except KeyError as error:
                warn("%s: %s" % (block_id, error))
                continue
            if not elements:
                warn("%s draws %s, which has no elements" % (block_id, choice["model"]))
            full = full or is_full_cube(elements)
            x_turns, y_turns = choice.get("x", 0) // 90, choice.get("y", 0) // 90
            for element in elements:
                turned = turn_element(element, x_turns, y_turns, choice.get("uvlock", False))
                for face in turned["faces"].values():
                    ref = face["texture"]
                    face["texture"] = texture_key(textures.get(ref[1:], ref) if ref.startswith("#") else ref)
                parts.append(turned)
        see_through = any(word in block_id for word in SEE_THROUGH)
        states.append({"id": block_id, "parts": parts, "full": full and not see_through, "glass": see_through})

    grid = {}
    for block in structure["blocks"]:
        state = states[block["state"]]
        if state:
            grid[tuple(block["pos"])] = state

    def hides(pos, direction, own):
        other = grid.get(tuple(p + d for p, d in zip(pos, DIRECTIONS[direction])))
        if other is None:
            return False
        return other["full"] or (own["glass"] and other["id"] == own["id"])

    # Centred on x and z, and standing on y 8 or centred on it, the structure has
    #  24 units each way from the middle to fit in, and 24 up from it standing
    def fits(display):
        k = scale * 16 / display
        tall = size[1] * k / 2 if middle else size[1] * k
        return size[0] * k / 2 <= 24 and size[2] * k / 2 <= 24 and tall <= 24
    display = next((d for d in DISPLAY_SCALES if fits(d)), DISPLAY_SCALES[-1])
    k = scale / display

    # The nudge is in blocks as the display shows it facing 0, which draws the
    #  model turned half round, so it goes into the model with x and z reversed
    nudge = [n * 16 / display for n in (-nudge[0], nudge[1], -nudge[2])]
    floor = 8 - size[1] * 16 * k / 2 if middle else 8
    offset = (8 - size[0] * 16 * k / 2 + nudge[0], floor + nudge[1], 8 - size[2] * 16 * k / 2 + nudge[2])

    def place(pos, p, inset=0):
        return [round((pos[i] * 16 + p[i] + (inset if i == 0 else 0)) * k + offset[i], 4) for i in range(3)]

    texture_names = {}
    elements = []
    culled = 0
    for pos, state in sorted(grid.items()):
        # A block set in is moved toward the structure's middle across x, by
        #  the pixels asked for
        inset = (insets or {}).get(state["id"], 0)
        if pos[0] + 0.5 > size[0] / 2:
            inset = -inset
        for part in state["parts"]:
            faces = {}
            for direction, face in part["faces"].items():
                if face["cullface"] and hides(pos, face["cullface"], state):
                    culled += 1
                    continue
                # A tinted texture is drawn as its plain stand-in, taking the
                #  item's first tint
                texture = (tints or {}).get(face["texture"], face["texture"])
                name = texture_names.setdefault(texture, "t%d" % len(texture_names))
                out = {"uv": [round(c, 4) for c in face["uv"]], "texture": "#" + name}
                if face["rotation"]:
                    out["rotation"] = face["rotation"]
                if face["texture"] in (tints or {}):
                    out["tintindex"] = 0
                faces[direction] = out
            if not faces:
                continue
            element = {"from": place(pos, part["from"], inset), "to": place(pos, part["to"], inset)}
            if "rotation" in part:
                spin = part["rotation"]
                element["rotation"] = {"origin": place(pos, spin["origin"], inset), "axis": spin["axis"],
                                       "angle": spin["angle"]}
                if spin["rescale"]:
                    element["rotation"]["rescale"] = True
            if not part["shade"]:
                element["shade"] = False
            element["faces"] = faces
            elements.append(element)

    for element in elements:
        for corner in (element["from"], element["to"]):
            if min(corner) < MODEL_MIN or max(corner) > MODEL_MAX:
                warn("an element reaches %s, past what an item model may hold" % corner)
                break

    textures = {name: texture_value(ref) for ref, name in texture_names.items()}
    counts = {}
    for element in elements:
        for face in element["faces"].values():
            counts[face["texture"]] = counts.get(face["texture"], 0) + 1
    if counts:
        textures["particle"] = max(counts, key=counts.get)
    return {"textures": textures, "elements": elements}, culled, display


def write_json(path, data):
    """Writes a model or item definition in the shape 'format_models.py' gives
    every other one, so running it afterwards changes nothing"""
    path.parent.mkdir(parents=True, exist_ok=True)
    format_models.sort_elements(data)
    text = format_models.fmt(data) + "\n"
    path.write_bytes(text.replace("\r\n", "\n").replace("\n", "\r\n").encode("utf-8"))


def block_ids(structure):
    """Each block of a structure that is not air, by its position, as its id"""
    ids = {}
    for block in structure["blocks"]:
        entry = structure["palette"][block["state"]]
        block_id = full_ref(entry.get("Name") or entry["id"])
        if block_id not in ("minecraft:air", "minecraft:structure_void", "minecraft:cave_air"):
            ids[tuple(block["pos"])] = block_id
    return ids


def cut(structure, part):
    """Takes every copy of a part out of a structure, matched by block id alone,
    since stairs and walls beside other blocks take other shapes, and returns
    where each copy's corner was"""
    body = block_ids(structure)
    shape = block_ids(part)
    size, part_size = structure["size"], part["size"]
    found = []
    for ox in range(size[0] - part_size[0] + 1):
        for oy in range(size[1] - part_size[1] + 1):
            for oz in range(size[2] - part_size[2] + 1):
                if all(body.get((x + ox, y + oy, z + oz)) == block_id
                       for (x, y, z), block_id in shape.items()):
                    found.append((ox, oy, oz))
    gone = {(x + ox, y + oy, z + oz) for ox, oy, oz in found for (x, y, z) in shape}
    structure["blocks"] = [b for b in structure["blocks"] if tuple(b["pos"]) not in gone]
    return found


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("structure", type=Path)
    parser.add_argument("--scale", type=float, required=True,
                        help="how big one of the structure's blocks is in the world")
    parser.add_argument("--name", required=True, help="the model's name under derailed:item/")
    parser.add_argument("--nudge", default="0,0,0",
                        help="x,y,z blocks to shift the model by, as the display shows it facing 0, "
                             "the way a display's translation would before it turns")
    parser.add_argument("--cut", type=Path, action="append", default=[],
                        help="a structure every copy of which is left out of the model, such as "
                             "wheels shown by a display of their own; where each axle lies is printed")
    parser.add_argument("--middle", action="store_true",
                        help="centre the model on the display rather than standing it on it, "
                             "for a part that spins about its middle")
    parser.add_argument("--inset", action="append", default=[],
                        help="block=pixels: move that block toward the structure's middle across x")
    parser.add_argument("--tint", default=None,
                        help="texture=plain: draw that texture as the plain one, coloured by the item's "
                             "custom_model_data colours[0], which defaults to the colour that makes it "
                             "look as the texture does")
    parser.add_argument("--jar", type=Path, default=DEFAULT_JAR)
    args = parser.parse_args()

    warnings = []
    assets = Assets(args.jar)
    structure = load_structure(args.structure)
    nudge = [float(n) for n in args.nudge.split(",")]
    insets = {full_ref(i.split("=")[0]): float(i.split("=")[1]) for i in args.inset}

    # A tint multiplies the plain texture, so the colour that makes it look as
    #  the texture it stands in for does is the one's colour over the other's
    tints, tint_default = None, None
    if args.tint:
        texture, plain = (full_ref(t if "/" in t else "block/" + t) for t in args.tint.split("="))
        tints = {texture: plain}
        want, have = assets.average_colour(texture), assets.average_colour(plain)
        rgb = [min(255, round(w / h * 255)) for w, h in zip(want, have)]
        tint_default = rgb[0] * 65536 + rgb[1] * 256 + rgb[2]

    # Where each part cut out lies, from the middle of the display: ahead of it
    #  toward the model's front, which is the structure's +z, and up from its
    #  floor, in blocks in the world
    axles = []
    size = structure["size"]
    for path in args.cut:
        part = load_structure(path)
        for ox, oy, oz in cut(structure, part):
            centre = [o + s / 2 for o, s in zip((ox, oy, oz), part["size"])]
            ahead = (centre[2] - size[2] / 2) * args.scale - nudge[2]
            up = centre[1] * args.scale + nudge[1]
            axles.append((path.stem, ahead, up))

    model, culled, display = bake(structure, assets, args.scale, warnings.append, nudge,
                                  args.middle, insets, tints)

    model_path = RESOURCEPACK / "assets" / "derailed" / "models" / "item" / (args.name + ".json")
    item_path = RESOURCEPACK / "assets" / "derailed" / "items" / (args.name + ".json")
    write_json(model_path, model)
    item = {"type": "minecraft:model", "model": "derailed:item/" + args.name}
    if tints:
        item["tints"] = [{"type": "minecraft:custom_model_data", "index": 0, "default": tint_default}]
    write_json(item_path, {"model": item})

    print("%d elements, %d textures, %d faces culled" % (
        len(model["elements"]), len(model["textures"]) - 1, culled))
    print("wrote %s" % model_path.relative_to(ROOT).as_posix())
    print("wrote %s" % item_path.relative_to(ROOT).as_posix())
    if tints:
        print("tinted, defaulting to %d, %d, %d (%d)" % (
            tint_default >> 16, tint_default >> 8 & 255, tint_default & 255, tint_default))
    print()
    print("baked for a display scaled by %s:" % display)
    print('  summon item_display ~ ~ ~ {item:{id:"stick",components:{"minecraft:item_model":"derailed:%s"}},'
          'transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],'
          'scale:[%sf,%sf,%sf]}}' % (args.name, display, display, display))
    if axles:
        print()
        print("cut out, from the display's middle:")
        for name, ahead, up in sorted(axles, key=lambda a: -a[1]):
            print("  %-20s %+.4f ahead, %.4f up" % (name, ahead, up))
    for warning in sorted(set(warnings)):
        print("warning: %s" % warning)
    return 0


if __name__ == "__main__":
    sys.exit(main())
