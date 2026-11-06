"""Bakes the fire drawn over each piece of a train while it burns.

Each piece has a copy of its structure with fire laid over it in
utils/structures, '<piece>_burning'. Only the fire is kept, and baked by
'bake_structure_model' into an item model of the same name, at the scale and
nudge its piece's own model is baked at. The structure is the same size as the
piece's, so the bake comes out at the same display scale too, and a display
riding the piece, scaled and turned as the piece is, lays the fire over it
block for block.

A fire on the floor, burning on no side and under no ceiling, that stands on a
bottom slab or the bottom half of stairs is moved down half a block onto it.
Vanilla draws each fire block with one of its models picked at random; here
each block's are picked from SEED, so a bake comes out the same every time.

Run from the repository root: py -3 utils/bake_burning.py
"""

import random
import sys
from pathlib import Path

import bake_structure_model as bake

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
STRUCTURES = SCRIPT_DIR / "structures"
ASSETS = ROOT / "resourcepack" / "assets" / "derailed"

SCALE = 0.3
SEED = 0

# Each piece and the nudge its own model is baked with
PIECES = {
    "train": (0, 0, -0.3),
    "water_wagon": (0, 0, 0),
    "supply_wagon": (0, 0, 0),
    "crafting_wagon": (0, 0, 0),
}

SIDES = ("north", "east", "south", "west", "up")


def on_floor(state):
    """Whether a fire burns on no side and under no ceiling"""
    properties = state.get("properties", {})
    return not any(str(properties.get(side)) == "true" for side in SIDES)


def low(state):
    """Whether a block's top stands half a block up: a bottom slab, or stairs
    the right way up"""
    if state is None:
        return False
    properties = state.get("properties", {})
    if state["id"].endswith("_slab"):
        return properties.get("type") == "bottom"
    if state["id"].endswith("_stairs"):
        return properties.get("half") == "bottom"
    return False


def fire_only(structure):
    """The structure with only its fire, each block a palette entry of its own
    so its model is picked on its own, those on a low floor half a block down"""
    grid = {tuple(block["pos"]): structure["palette"][block["state"]] for block in structure["blocks"]}
    palette, blocks, lowered = [], [], 0
    for (x, y, z), state in sorted(grid.items()):
        if state["id"] != "minecraft:fire":
            continue
        if on_floor(state) and low(grid.get((x, y - 1, z))):
            y -= 0.5
            lowered += 1
        palette.append(state)
        blocks.append({"pos": [x, y, z], "state": len(palette) - 1})
    return {"size": structure["size"], "palette": palette, "blocks": blocks}, lowered


def main():
    assets = bake.Assets(bake.DEFAULT_JAR)
    choices = random.Random(SEED)
    bake.pick = lambda choice: choices.choice(choice) if isinstance(choice, list) else choice

    for piece, nudge in PIECES.items():
        name = piece + "_burning"
        structure, lowered = fire_only(bake.load_structure(STRUCTURES / (name + ".nbt")))
        warnings = []
        model, _, display = bake.bake(structure, assets, SCALE, warnings.append, nudge)
        bake.write_json(ASSETS / "models" / "item" / (name + ".json"), model)
        bake.write_json(ASSETS / "items" / (name + ".json"),
                        {"model": {"type": "minecraft:model", "model": "derailed:item/" + name}})
        print("%s: %d fires, %d lowered, %d elements, for a display scaled by %s" % (
            name, len(structure["blocks"]), lowered, len(model["elements"]), display))
        for warning in sorted(set(warnings)):
            print("  warning: %s" % warning)
    return 0


if __name__ == "__main__":
    sys.exit(main())
