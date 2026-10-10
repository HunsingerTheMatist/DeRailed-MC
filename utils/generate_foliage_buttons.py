"""
Generates the powered buttons that stand in for the foliage on tree tiles, and
the stone buttons left on iron and spruce tiles as pebbles.

A powered button cannot be pressed, has no hitbox, and is not a solid block, so
a plant drawn in its space is lit from that space the way a plant's own block
would be. Only the powered floor and ceiling states are drawn as foliage, so
unpowered buttons and buttons on walls, such as the station's, keep their
vanilla look.

On the floor, a button's facing picks the plant (FLOOR). Vanilla offsets most
plants a little from the middle of their block, by a random amount each
position keeps; buttons have no offset of their own, so each such plant is
drawn from 16 copies of its model shifted across a grid within vanilla's
reach, listed as a blockstate's weighted variants, which the game picks among
by position the same way. On the ceiling, a button is a shelf mushroom turned
the way its facing points, drawn in its own block, or in the block below for a
mushroom with nothing above it to hang a button from (CEILING).

Stone buttons placed powered are drawn as unpowered, so pebbles look as they
always did but cannot be pressed.

Every model a plant is drawn from is read the way the game reads it, from the
resource pack first and the vanilla jar second, its parents walked up to their
elements, and written out whole, so the copies need nothing else to load.

Usage:
    py -3 generate_foliage_buttons.py

writes resourcepack/assets/derailed/models/block/foliage/offset/*.json, the
shifted shelf mushrooms beside them, and the blockstates of every button below
under resourcepack/assets/minecraft/blockstates/
"""
import json
import zipfile
from pathlib import Path

from format_models import fmt

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
RESOURCEPACK = ROOT / "resourcepack" / "assets"
JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"
OFFSET_DIR = RESOURCEPACK / "derailed" / "models" / "block" / "foliage" / "offset"
FOLIAGE_DIR = RESOURCEPACK / "derailed" / "models" / "block" / "foliage"
BLOCKSTATES = RESOURCEPACK / "minecraft" / "blockstates"

# The plant each powered floor button draws by its facing, and how vanilla
#  offsets it: "xyz" across and a little down, "xz" across only, None not at all
FLOOR = {
    "cherry": {
        "north": ("derailed:block/foliage/short_grass", "xyz"),
        "east": ("derailed:block/foliage/fern", "xyz"),
        "south": ("derailed:block/foliage/tall_grass", "xz"),
        "west": ("derailed:block/foliage/large_fern", "xz"),
    },
    "pale_oak": {
        "north": ("derailed:block/foliage/bush", None),
        "east": ("minecraft:block/red_mushroom", None),
        "south": ("minecraft:block/brown_mushroom", None),
    },
    "poplar": {
        "north": ("minecraft:block/oak_sapling", None),
        "east": ("minecraft:block/spruce_sapling", None),
    },
}

# The shelf mushroom each powered ceiling button draws: its age, and whether it
#  is drawn in the block below the button's
CEILING = {
    "cherry": (0, False),
    "pale_oak": (1, False),
    "poplar": (0, True),
    "jungle": (1, True),
}

# The turn vanilla gives a shelf mushroom for each facing
FACING_Y = {"north": 0, "east": 90, "south": 180, "west": 270}
FACINGS = ("north", "east", "south", "west")

# Vanilla moves a plant up to a quarter block either way across, in 16 steps,
#  and up to 0.2 down; the copies take a 4 by 4 grid of the steps across, and
#  for "xyz" each its own step down, spread so neighbours differ
ACROSS = (-4.0, -4 / 3, 4 / 3, 4.0)
DOWN_STEPS = (11, 3, 14, 6, 0, 9, 2, 13, 7, 15, 4, 10, 1, 12, 5, 8)


class Assets:
    """Reads models from the resource pack first and the vanilla jar second,
    the order the game layers them in"""

    def __init__(self, jar):
        self.jar = zipfile.ZipFile(jar)

    def read(self, path):
        local = RESOURCEPACK / path
        if local.is_file():
            return json.loads(local.read_text(encoding="utf-8"))
        return json.loads(self.jar.read("assets/" + path))

    def model(self, ref):
        namespace, _, name = ref.partition(":") if ":" in ref else ("minecraft", "", ref)
        return self.read("%s/models/%s.json" % (namespace, name))

    def resolve(self, ref):
        """The model with its parents walked up: textures merged, the child's
        winning, and the elements and ambient occlusion of the nearest model
        that gives them"""
        textures, elements, ambient = {}, None, None
        while ref:
            data = self.model(ref)
            for key, value in data.get("textures", {}).items():
                textures.setdefault(key, value)
            if elements is None and "elements" in data:
                elements = data["elements"]
            if ambient is None and "ambientocclusion" in data:
                ambient = data["ambientocclusion"]
            ref = data.get("parent")
            if ref and ref.removeprefix("minecraft:") in ("block/block", "builtin/generated"):
                break
        model = {}
        if ambient is not None:
            model["ambientocclusion"] = ambient
        model["textures"] = textures
        model["elements"] = elements or []
        return model


def shifted(model, dx, dy, dz):
    """A copy of the model with every element moved dx, dy, dz pixels"""
    out = json.loads(json.dumps(model))
    for element in out["elements"]:
        for key in ("from", "to"):
            element[key] = [round(v + d, 4) for v, d in zip(element[key], (dx, dy, dz))]
        if "rotation" in element and "origin" in element["rotation"]:
            element["rotation"]["origin"] = [round(v + d, 4) for v, d in zip(element["rotation"]["origin"], (dx, dy, dz))]
    return out


def write_json(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\r\n") as f:
        f.write(text)


def main():
    assets = Assets(JAR)

    # The offset copies of every plant that has one, any left from a plant that
    #  no longer does cleared first
    for old in OFFSET_DIR.glob("*.json"):
        old.unlink()
    plants = {}
    for facings in FLOOR.values():
        for ref, offset in facings.values():
            if offset:
                plants[ref] = offset
    for ref, offset in plants.items():
        base = assets.resolve(ref)
        name = ref.split("/")[-1]
        n = 0
        for x in ACROSS:
            for z in ACROSS:
                y = (DOWN_STEPS[n] / 15 - 1) * 3.2 if offset == "xyz" else 0.0
                write_json(OFFSET_DIR / ("%s_%d.json" % (name, n)), fmt(shifted(base, x, y, z)) + "\n")
                n += 1
        print("offsets", name, n)

    # The shelf mushrooms drawn a block below
    for age in sorted({age for age, below in CEILING.values() if below}):
        base = assets.resolve("minecraft:block/shelf_mushroom_stage%d" % age)
        write_json(FOLIAGE_DIR / ("shelf_mushroom_stage%d_below.json" % age), fmt(shifted(base, 0, -16, 0)) + "\n")

    def plant_variant(ref, offset):
        if not offset:
            return {"model": ref}
        name = ref.split("/")[-1]
        return [{"model": "derailed:block/foliage/offset/%s_%d" % (name, n)} for n in range(16)]

    # The buttons: vanilla's blockstate with its powered floor and ceiling
    #  states drawn as foliage
    for button in sorted(set(FLOOR) | set(CEILING)):
        state = json.loads(assets.jar.read("assets/minecraft/blockstates/%s_button.json" % button))
        variants = state["variants"]
        for facing, (ref, offset) in FLOOR.get(button, {}).items():
            variants["face=floor,facing=%s,powered=true" % facing] = plant_variant(ref, offset)
        if button in CEILING:
            age, below = CEILING[button]
            ref = ("derailed:block/foliage/shelf_mushroom_stage%d_below" if below else "minecraft:block/shelf_mushroom_stage%d") % age
            for facing in FACINGS:
                variant = {"model": ref}
                if FACING_Y[facing]:
                    variant["y"] = FACING_Y[facing]
                variants["face=ceiling,facing=%s,powered=true" % facing] = variant
        write_json(BLOCKSTATES / ("%s_button.json" % button), json.dumps(state, indent=2) + "\n")
        print("blockstate", button)

    # Pebbles: powered stone buttons on the floor drawn as unpowered ones
    state = json.loads(assets.jar.read("assets/minecraft/blockstates/stone_button.json"))
    for facing in FACINGS:
        state["variants"]["face=floor,facing=%s,powered=true" % facing] = state["variants"]["face=floor,facing=%s,powered=false" % facing]
    write_json(BLOCKSTATES / "stone_button.json", json.dumps(state, indent=2) + "\n")
    print("blockstate stone")


if __name__ == "__main__":
    main()
