# Player Attributes

Decided values and the vanilla defaults they replace. These are per-player and
persistent, so they belong in `player/init.mcfunction` alongside the id
assignment rather than in `load`.

## Decided

| attribute | value | vanilla default |
|---|---|---|
| `minecraft:block_interaction_range` | **3** | 4.5 |
| `minecraft:entity_interaction_range` | **3.2** | 3.0 |
| `minecraft:block_break_speed` | **0** | 1.0 |
| `minecraft:jump_strength` | **0.39** | 0.42 |

```mcfunction
attribute @s minecraft:block_interaction_range base set 3
attribute @s minecraft:entity_interaction_range base set 3.2
attribute @s minecraft:block_break_speed base set 0
attribute @s minecraft:jump_strength base set 0.39
```

## Why each

**The two ranges are set together.** Vanilla ships them 1.5 apart - 4.5 for
blocks, 3.0 for entities - which meant a tool could be placed further away than
its interaction entity could be clicked, so you could put an item down and not
be able to pick it back up.

**Entity range is deliberately the larger of the two.** A block is reached at its
**near face**, while a placement's interaction sits at the **centre of the
tile**, so the entity is always fractionally the further of the two. Clicking
the top of a floor tile they are nearly the same distance, but clicking the side
of a block and placing on the tile beyond it, the entity can be up to half a
block further out than the face that was clicked. The 0.2 covers that.

The numbers are a feel decision; the ordering is not. Anything that raises block
range without raising entity range with it brings the soft lock back.

**Break speed goes to 0 so tools have to opt back in.** Tool items carry
`attribute_modifiers=[{type:block_break_speed,id:can_mine,slot:mainhand,amount:1,
operation:add_value}]`, which lands on a base of 0 and totals 1. Until the base
is actually set the total is 2, and everything mines twice as fast as intended.

## Mining time depends on this

Break time is `ceil(hardness * 30 / speed)` when the tool is correct for drops,
and it assumes the block break speed attribute totals 1.0. Any speed tuning has
to happen after the base is set to 0, or it is calibrated against the wrong
number.

There is no "set" operation for attribute modifiers - only `add_value`,
`add_multiplied_base` and `add_multiplied_total` - which is why the base has to
be changed by command rather than by a component.

## Carrying weighs a player down

The held item lowers its holder's jump strength by how many they carry and
their step height from 0.6 to 0.5 whatever they carry, through
`attribute_modifiers` on the main hand item that `player/_set_hand` writes
(ids `derailed:load_jump` and `derailed:load_step`). The modifiers leave with
the item, so an empty hand is back to the base, 0.39 (set in `player/init`),
with nothing to undo.

| carried | jump strength | modifier | highest jump |
|---|---|---|---|
| 0 | 0.39 | none | 1.105 blocks |
| 1 | 0.375 | -0.015 | 1.033 blocks |
| 2 | 0.325 | -0.065 | 0.797 blocks (12.76 px) |
| 3+ | 0.26 | -0.13 | 0.545 blocks |

A jump starts at the jump strength upward, and each tick the player rises by
that and it loses 0.08, then a fiftieth of what is left, so the highest jump is
the sum of the rises.

What it decides:

- **Resource piles.** Each pile is 0.5625 higher than the one under it, so an
  empty handed player walks up a staircase of piles on step height alone,
  while a player holding anything has to jump each one, and one carrying three
  or more cannot climb them at all.
- **The train.** Its boxes stand 0.3 above the display they ride (see
  [trains.md](trains.md)), so a player carrying two gets onto it only from a
  pile of five, and one carrying one or nothing from a pile of four.
- **Tools count.** An axe, pickaxe or bucket is one item, so holding one jumps
  as one carried.

Tools keep their `block_break_speed` modifier in the same list, after these
two.
