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

```mcfunction
attribute @s minecraft:block_interaction_range base set 3
attribute @s minecraft:entity_interaction_range base set 3.2
attribute @s minecraft:block_break_speed base set 0
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
