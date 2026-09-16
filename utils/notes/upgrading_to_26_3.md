# Upgrading DeRailed from 26.2 to 26.3

Written 2026-09-15, the day 26.3 released, and the upgrade is done. Every shape
below was checked against the 26.3 jar - its codecs and its own vanilla data
files - rather than taken on trust, and two things a video transcript got wrong
are called out where they come up.

## Pack formats

| pack | 26.2 | 26.3 |
|---|---|---|
| data | `107.1` | `121.0` |
| resource | `88.0` | `97.1` |

Both `pack.mcmeta` files pin `min_format` and `max_format` to the same value, so
both fields move. `pack_format_versions.json` is stale - it stops at `118.0`
(26.3-snapshot-10), so run `fetch_pack_format_versions.py` before `build.py`, or
`_pack_meta.resolve_target_mc_version` will not recognise the new format.

## What this pack has to change

### Generated loot tables - all 17, and all from one place

Every file under `loot_table/blocks/` is emitted by
`generate_resource_blocks.py`, so the whole migration is a change to
`build_loot_tables`. Four separate renames land on the same entry:

- an item modifier's `function` field is now `type`
- `functions` is now `modifier`, and takes **one** modifier, not a list
- `conditions` is now `condition` and takes one predicate, not a list
- `block_state_property` is now `match_block`, with `block` -> `blocks` and
  `properties` -> `state`

The transcript claims `modifier` is still a list. It is not - `LootPoolEntryContainer`
reads both as single optional holders, and vanilla's `wheat.json` writes
`"modifier": {"type": "minecraft:explosion_decay"}`:

```java
i.group(LootItemCondition.CODEC.optionalFieldOf("condition")...,
        LootItemFunctions.CODEC.optionalFieldOf("modifier")...)
```

More than one modifier now needs a `minecraft:sequence` wrapping them.

So each entry goes from this:

```json
{
  "type": "minecraft:item",
  "name": "minecraft:wheat_seeds",
  "conditions": [
    {"condition": "minecraft:block_state_property",
     "block": "minecraft:azalea_leaves",
     "properties": {"persistent": "true", "waterlogged": "false"}}
  ],
  "functions": [
    {"function": "minecraft:set_custom_data", "tag": "{dr_mined:{...}}"}
  ]
}
```

to this:

```json
{
  "type": "minecraft:item",
  "name": "minecraft:wheat_seeds",
  "condition": {
    "type": "minecraft:match_block",
    "blocks": "minecraft:azalea_leaves",
    "state": {"persistent": "true", "waterlogged": "false"}
  },
  "modifier": [
    {"type": "minecraft:set_custom_data", "tag": "{dr_mined:{...}}"}
  ]
}
```

`rolls: 1` is already an integer, which 26.3 now requires - a float there is an
error. An `minecraft:item` entry's `name` field is untouched; only the `tag`
entry type renamed `name` to `items` **verify**.

### Inline modifiers in mcfunctions - three commands

The same `function` -> `type` rename reaches SNBT written inline in a command,
not just JSON files. `item modify` takes an item modifier directly:

```mcfunction
item modify entity @s weapon.mainhand [{type:set_components,components:{...}}]
```

26.2 dispatched on a named key, 26.3 dropped the name and so defaults to `type`:

```java
// 26.2
TYPED_CODEC = ...byNameCodec().dispatch("function", LootItemFunction::codec, c -> c);
// 26.3
TYPED_CODEC = ...byNameCodec().dispatch(LootItemFunction::codec, c -> c);
```

The `[...]` list form still works - `DIRECT_CODEC` is an `either` of the typed
codec and `SequenceFunction.INLINE_CODEC` - so only the key needed changing, in
`bucket/empty`, `bucket/fill` and `placement/_add_item_display`.

This one is worth remembering because of how it fails. A command that will not
parse stops its **whole function** from loading, so the visible symptom was that
placements summoned no item display at all - nowhere near the bucket line that
was actually malformed. Grepping only `*.json` for the renamed keys misses this
entirely; grep the mcfunctions too.

### Predicates - both files

`predicate/is_sneaking.json` and `is_sprinting.json` need `condition` renamed to
`type`. Each file is a single object rather than a list, so neither needs the
new `all_of` wrapper that a top-level list would now require.

`execute if predicate derailed:is_sneaking` is unaffected - that is a command
argument, not the removed `reference` predicate type.

### Advancements - two of three

`spawn_egg_use.json` has `location` as a one-element list of predicates. Lists
are no longer allowed there, and `condition` becomes `type`:

```json
"conditions": {
  "location": {
    "type": "minecraft:match_tool",
    "predicate": {"items": "minecraft:panda_spawn_egg"}
  }
}
```

`interaction_use.json` puts a bare entity predicate under `entity`. Both
`entity` and `location` are now `Optional<Holder<LootItemCondition>>`, so that
shorthand is gone and a full `entity_properties` predicate is required. Its
inner `entity` field is `fieldOf`, not optional, so it has to be given - and
`PlayerInteractTrigger.trigger` builds its context with the interacted entity as
`THIS_ENTITY`, which makes the right target `this`:

```json
"conditions": {
  "entity": {
    "type": "minecraft:entity_properties",
    "entity": "this",
    "predicate": {"entity_type": "interaction"}
  }
}
```

`bucket_tick.json` is a bare `tick` trigger with no conditions and no `display`,
so it needs nothing. None of the three declare `display`, which means the new
rule that `parent` and `background` are mutually exclusive and one is required
does not reach this pack.

### The biome

`worldgen/biome/game.json` still has top-level `spawners` and `spawn_costs`.
Both moved into the new `minecraft:gameplay/natural_mob_spawns` environment
attribute, and `spawners` was renamed `spawns_by_category`. The file already has
an `attributes` object holding `minecraft:visual/sky_color`, so they go beside
it.

An environment attribute is not the bare value - it is an object of `argument`
and `modifier`, which `minecraft:visual/sky_color` hides by accepting a string
shorthand. Vanilla's `the_void` is the exact template, since it also suppresses
every category:

```json
"minecraft:gameplay/natural_mob_spawns": {
  "argument": {"spawn_costs": {}, "spawns_by_category": {"ambient": [], ...}},
  "modifier": "overlay"
}
```

Not omitted, even though every list here is empty: all 67 vanilla biomes declare
the attribute, so there is no evidence the default suppresses spawning.

`min_count`/`max_count` collapsing into a single `count` does not apply, since
no category has entries.

## Confirmed not to affect this pack

Checked rather than assumed, so these do not need revisiting:

- `swing_animation` split into `attack_animation`/`interact_animation` - neither
  the old nor the new component appears anywhere
- `map_color` removal - not used
- cooking recipe `cookingtime` now required, and doubled for smoker and blast
  furnace - no recipes in this pack
- number providers needing an explicit `type: uniform` - the only number is
  `rolls: 1`, a bare integer
- villager trades, trim materials, brewing fuel tag, carver replaceable tags
- features, carvers, density functions, noise, noise settings - the biome's
  `features` and `carvers` are both empty lists
- `loot_table/entities/shulker.json` is `{}` and has nothing to rename

## New in 26.3 that may be worth using later

**`minecraft:block_transformer`** is the axe-strips-a-log mechanic generalised
into a component: a list of transforms with `block_state_provider`, `loot`,
`drop_strategy`, `sound`, `particle`, `consume_on_use`, `item_damage_per_use`
and `disallowed_faces`. It fires on *use*, not on breaking, so it does not
replace the mining chain - but it is close to what the bucket and rail placement
do by hand.

**`/compute`** evaluates a number provider and stores the result, in integer or
float mode. Worth remembering next time something needs arithmetic that
scoreboards make awkward.

**`minecraft:height_range` block predicate** takes `min_inclusive` and
`max_inclusive` vertical anchors. Possibly useful to the reachability flood fill
for bounding the search.

**`minecraft:waxed`** is now a marker component rather than a separate block
family concern. The stone chain uses unwaxed `copper_block` and `cut_copper`,
which are safe only because `random_tick_speed` is 0 - this component may offer
a second guard.

**Material rules can live in their own files** under `worldgen/material_rule`,
and a noise settings file can name one instead of inlining it. Only matters if
this pack ever gains custom terrain.

## Still to confirm in game

Everything above is verified against the jar, but nothing has been loaded yet.
Open the world and read the server log - a malformed predicate or advancement is
reported there rather than failing silently. Worth exercising specifically:

- chop a stage and confirm a seed still drops and dispatches, which covers
  `match_block`, `modifier` and the whole generated loot table shape
- right-click a placement, which covers `interaction_use`
- sneak while taking from a pile, which covers the two predicate files
- stand in the game dimension a while and confirm nothing spawns
