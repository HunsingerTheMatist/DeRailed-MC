"""
Builds every artifact that describes a mineable resource block from the single
source of truth in resource_blocks.json:

  datapack/data/minecraft/loot_table/blocks/<block>.json
      The seed a broken block drops, stamped with the resource type and the
      biome it belongs to. Nothing else reports a broken block to a datapack.
  datapack/data/derailed/tags/block/<category>/mineable_<family>.json
      One tag per tool rule, so a rule can carry the speed that family needs.

A block's loot table id is `id.withPrefix("blocks/")`, keyed on the block's own
registry id, so the loot tables are pinned flat; only the block tags are free
to sit in a category folder.

Tool speeds are solved rather than declared. Mining time is
`ceil(hardness * 30 / speed)`, so a resource type states the stage_ticks it
wants and each family's speed follows from its hardness. That keeps every break
of a tile feeling the same even where its blocks differ in hardness. Print the
solved rules with --rules and paste them into fix_items.mcfunction.

Generated paths are recorded in generated_manifest.json. A path under the
datapack that a previous run wrote and this one did not is deleted, so renaming
a block cannot leave a stale loot table overriding vanilla behind. A path under
the resource pack is only reported, since this no longer writes any there.

Usage:
  py -3 generate_resource_blocks.py            write the generated files
  py -3 generate_resource_blocks.py --check    report drift without writing
  py -3 generate_resource_blocks.py --rules    also print the tool rule snippet
"""
import argparse
import json
import math
import re
import sys
from collections import defaultdict
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # repo root (one level up from utils/)
SOURCE_FILE = SCRIPT_DIR / "resource_blocks.json"
MANIFEST_FILE = SCRIPT_DIR / "generated_manifest.json"
LOAD_MCFUNCTION = ROOT / "datapack" / "data" / "derailed" / "function" / "load.mcfunction"

DATAPACK = ROOT / "datapack" / "data"

LOOT_TABLE_DIR = DATAPACK / "minecraft" / "loot_table" / "blocks"
TAG_DIR = DATAPACK / "derailed" / "tags" / "block"

# The item a broken block drops purely as a signal. It is read and killed by
#  'derailed:item/event/block_mined', never by a player
SEED_ITEM = "minecraft:wheat_seeds"

# Vanilla's mining time formula, ceil(hardness * 30 / speed)
TICKS_PER_HARDNESS = 30

# The most decimals a solved tool speed may use before the solver gives up
MAX_SPEED_DECIMALS = 6

BLOCK_ID = re.compile(r"^[a-z_]+$")
CONST_SETTER = re.compile(r"^scoreboard players set (\$\w+) dr_const (\d+)\s*$")


class SourceError(Exception):
    """A problem in resource_blocks.json that makes generation meaningless"""


def load_resource_ids():
    """Reads the resource type ids out of load.mcfunction so the numbers stay
    declared in exactly one place"""
    ids = {}
    for line in LOAD_MCFUNCTION.read_text(encoding="utf-8").splitlines():
        match = CONST_SETTER.match(line)
        if match:
            ids[match.group(1)] = int(match.group(2))
    return ids


def load_source():
    source = json.loads(SOURCE_FILE.read_text(encoding="utf-8"))
    families = {k: v for k, v in source["hardness_families"].items() if not k.startswith("_")}
    types = {k: v for k, v in source["resource_types"].items() if not k.startswith("_")}
    return families, types, source["resource_blocks"]


def family_of(families, block_id):
    """The hardness family a block belongs to, or None"""
    for name, family in families.items():
        if block_id in family["blocks"]:
            return name
    return None


def resource_number(types, resource_ids, entry):
    """The dr_const value standing for this entry's resource type

    A seed records this and the biome rather than the entry's position, so
    inserting or reordering a biome cannot change what an already placed block
    means"""
    return resource_ids[types[entry["resource_type"]]["id"]]


def describe(entry):
    """How an entry is named in errors"""
    return "biome %s %s" % (entry["biome"], entry["resource_type"])


def validate(families, types, blocks, resource_ids):
    """Raises on anything that would generate a broken pack"""
    # A block id carries one loot table, so it can belong to one entry only
    owner = {}
    seen = set()
    for entry in blocks:
        resource = entry["resource_type"]
        if resource not in types:
            raise SourceError("the biome %s entry uses undeclared resource_type %r"
                              % (entry["biome"], resource))
        if types[resource]["id"] not in resource_ids:
            raise SourceError("%s: %s is not set in load.mcfunction"
                              % (describe(entry), types[resource]["id"]))

        # A resource type and biome pair is what every seed names, so two
        #  entries answering to one could not be told apart
        label = describe(entry)
        if label in seen:
            raise SourceError("two entries are both %s - a resource type and biome pair may "
                              "appear only once" % label)
        seen.add(label)

        if not entry["blocks"]:
            raise SourceError("%s has no blocks" % label)

        for block_id in entry["blocks"]:
            if not BLOCK_ID.match(block_id):
                raise SourceError("%s: %r is not a plain block id" % (label, block_id))
            if family_of(families, block_id) is None:
                raise SourceError("%s: %s is in no hardness family" % (label, block_id))
            if owner.setdefault(block_id, label) != label:
                raise SourceError("%s: %s already belongs to %s" % (label, block_id, owner[block_id]))

    # Two resource types sharing a category would write their tags over each
    #  other
    claimed = {}
    for resource, spec in sorted(types.items()):
        if claimed.setdefault(spec["category"], resource) != resource:
            raise SourceError("resource types %r and %r both use category %r"
                              % (claimed[spec["category"]], resource, spec["category"]))

    # A family mined by two resource types would need two speeds in one tag
    used_by = {}
    for entry in blocks:
        for block_id in entry["blocks"]:
            family = family_of(families, block_id)
            if used_by.setdefault(family, entry["resource_type"]) != entry["resource_type"]:
                raise SourceError("family %r is used by both %r and %r - give each its own family"
                                  % (family, used_by[family], entry["resource_type"]))


def solved_speed(hardness, ticks):
    """The shortest tool speed that mines a block of this hardness in `ticks`

    Because the formula ceils, a whole range of speeds share a tick count -
    every s with hardness * 30 / ticks <= s < hardness * 30 / (ticks - 1). So
    rather than writing the exact quotient out to a fixed width, this walks
    decimal places from none upward and takes the first value that lands inside
    the window, which keeps the number in the tool rule readable. Rounding is
    always up, since rounding down leaves the division a hair past the tick it
    was solved for and the ceil turns that hair into a whole extra tick"""
    exact = hardness * TICKS_PER_HARDNESS / ticks
    for decimals in range(MAX_SPEED_DECIMALS + 1):
        scale = 10 ** decimals
        speed = math.ceil(exact * scale) / scale
        if speed > 0 and math.ceil(hardness * TICKS_PER_HARDNESS / speed) == ticks:
            return int(speed) if decimals == 0 else round(speed, decimals)
    raise SourceError(
        "no speed within %d decimals mines hardness %s in %d ticks - the window "
        "narrows as the tick count grows" % (MAX_SPEED_DECIMALS, hardness, ticks))


def build_loot_tables(types, resource_ids, blocks, out):
    """One loot table per block id, dropping the seed that names its resource
    type and biome"""
    for entry in blocks:
        tag = "{dr_mined:{resource:%d,biome:%d}}" % (
            resource_number(types, resource_ids, entry), entry["biome"])
        for block_id in entry["blocks"]:
            out[LOOT_TABLE_DIR / (block_id + ".json")] = {
                "type": "minecraft:block",
                "pools": [{
                    "rolls": 1,
                    "entries": [{
                        "type": "minecraft:item",
                        "name": SEED_ITEM,
                        "modifier": {"type": "minecraft:set_custom_data", "tag": tag},
                    }],
                }],
            }


def mineable_sets(families, blocks):
    """Maps (resource type, hardness family) to the block ids a tool rule for
    that pair must cover"""
    mineable = defaultdict(set)
    for entry in blocks:
        for block_id in entry["blocks"]:
            mineable[(entry["resource_type"], family_of(families, block_id))].add(block_id)
    return mineable


def build_tags(types, families, blocks, out):
    """One tag per tool rule, under the resource type's category"""
    for (resource, family), block_ids in sorted(mineable_sets(families, blocks).items()):
        category = types[resource]["category"]
        out[TAG_DIR / category / ("mineable_%s.json" % family)] = {"values": sorted(block_ids)}


def prune_empty_dirs(directory):
    """Removes a directory an orphan left empty, and any parent it empties in
    turn. Stops at the datapack's root so it can never walk out of the pack"""
    while directory != DATAPACK and DATAPACK in directory.parents:
        if not directory.is_dir() or any(directory.iterdir()):
            return
        directory.rmdir()
        directory = directory.parent


def render(content):
    """JSON with two-space indent, CRLF with a trailing newline, like every
    other file in the repo"""
    text = json.dumps(content, indent=2)
    return text.replace("\r\n", "\n").replace("\n", "\r\n") + "\r\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--check", action="store_true",
                        help="report what would change without writing anything")
    parser.add_argument("--rules", action="store_true",
                        help="print the solved tool rules for fix_items.mcfunction")
    args = parser.parse_args()

    families, types, blocks = load_source()
    resource_ids = load_resource_ids()
    try:
        validate(families, types, blocks, resource_ids)
    except SourceError as error:
        print("error: %s" % error, file=sys.stderr)
        return 1

    out = {}
    build_loot_tables(types, resource_ids, blocks, out)
    build_tags(types, families, blocks, out)

    rendered = {path: render(content) for path, content in out.items()}
    new_paths = sorted(p.relative_to(ROOT).as_posix() for p in rendered)
    old_paths = []
    if MANIFEST_FILE.is_file():
        old_paths = json.loads(MANIFEST_FILE.read_text(encoding="utf-8"))["paths"]
    orphans = [p for p in old_paths if p not in set(new_paths)]
    left = [p for p in orphans if not p.startswith("datapack/")]
    orphans = [p for p in orphans if p.startswith("datapack/")]

    changed = []
    for path, text in sorted(rendered.items()):
        existing = path.read_bytes().decode("utf-8") if path.is_file() else None
        if existing != text:
            changed.append(path.relative_to(ROOT).as_posix())

    if args.check:
        for path in changed:
            print("would write  %s" % path)
        for path in orphans:
            print("would delete %s" % path)
    else:
        for path, text in sorted(rendered.items()):
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(text.encode("utf-8"))
        for path in orphans:
            target = ROOT / path
            if target.is_file():
                target.unlink()
            prune_empty_dirs(target.parent)
        MANIFEST_FILE.write_bytes(
            (json.dumps({"paths": new_paths}, indent=2).replace("\n", "\r\n") + "\r\n").encode("utf-8"))
        print("wrote %d files (%d changed), deleted %d orphans"
              % (len(rendered), len(changed), len(orphans)))

    for path in left:
        print("no longer generated, left as it is: %s" % path)

    print()
    print("%-10s %-9s %-8s %-6s %s" % ("resource", "family", "hardness", "speed", "ticks"))
    used = sorted(mineable_sets(families, blocks))
    for resource, family in used:
        hardness = families[family]["hardness"]
        speed = solved_speed(hardness, types[resource]["stage_ticks"])
        ticks = math.ceil(hardness * TICKS_PER_HARDNESS / speed)
        print("%-10s %-9s %-8s %-6s %d" % (resource, family, hardness, speed, ticks))

    if args.rules:
        print()
        for resource in sorted(types):
            rules = ",".join(
                "{blocks:'#derailed:%s/mineable_%s',speed:%s,correct_for_drops:true}"
                % (types[r]["category"], family,
                   solved_speed(families[family]["hardness"], types[r]["stage_ticks"]))
                for r, family in used if r == resource)
            print("%s: tool={default_mining_speed:0,rules:[%s]}" % (resource, rules))
    return 0


if __name__ == "__main__":
    sys.exit(main())
