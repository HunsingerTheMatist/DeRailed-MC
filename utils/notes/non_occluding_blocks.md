# Blocks That Can Carry a Custom Model Without X-Ray

Reference notes captured 2026-09-07 for DeRailed (MC 26.2), while looking for
blocks to use as mining stages.

## The property that matters

A block gives its neighbours' faces away based on **`canOcclude`**, not on the
model it draws. `Block.shouldRenderFace`:

```java
VoxelShape occluder = neighborState.getFaceOcclusionShape(direction.getOpposite());
if (occluder == Shapes.block()) return false;
...
if (occluder == Shapes.empty()) return true;
```

`noOcclusion()` in a block's `BlockBehaviour.Properties` makes that shape empty,
so the block never culls anything next to it. Nothing in a resource pack can
change it — override a normal block's model with something smaller and the floor
and walls around it keep their faces culled, which reads in game as seeing
through the world.

So a block is safe to re-model only if it was registered with `noOcclusion()`.

In [MCPropertyEncyclopedia](https://github.com/JoakimThorsen/MCPropertyEncyclopedia)
this is the **`opaque`** property, defined as
`BlockBehaviour.BlockStateBase#canOcclude`. Its default is `Yes`; the blocks
listed below are the ones set to `No`. That dataset tracks 1.21.4, so anything
taken from it is worth confirming against the 26.2 sources.

## The candidates

Every family that is non-opaque, a full cube, and has collision. Hardness
matters because mining time is `ceil(hardness * 30 / speed)`.

| family    | hardness | variants | notes |
|----------------|-----|----|---|
| Stained Glass  | 0.3 | 16 | nothing odd at all |
| Glass          | 0.3 | 1  | |
| Tinted Glass   | 0.3 | 1  | |
| Leaves         | 0.2 | 12 | decays unless `persistent=true` |
| Mangrove Roots | 0.7 | 1  | waterloggable |
| Copper Grate   | 3   | 4 oxidation stages, 4 waxed | |
| Ice            | 0.5 | 1  | slippery, melts near light |
| Frosted Ice    | 0.5 | 1  | melts on its own |
| Slime Block    | 0   | 1  | bounces entities, sticks to pistons |
| Chorus Flower  | 0.4 | 1  | |
| Barrier        | infinite | 1 | unbreakable, so useless as a mining stage |
| Beacon         | 3   | 1  | ticking block entity, draws its own beam |
| Spawner        | 5   | 1  | ticking block entity, renders a mob inside |
| Trial Spawner  | 50  | 1  | ticking block entity |
| Vault          | 50  | 1  | ticking block entity |

Honey Block is missing from the list on purpose: it is non-opaque but not a full
cube. It turns up in the near-cube table below instead.

## Nearly a full cube

The same filter, but for blocks whose external collision measures 14 to 16
pixels on every axis rather than exactly 16. Small enough a gap that a custom
model still reads as filling the tile.

| family | size | hardness | notes |
|---|---|---|---|
| Sniffer Egg | 14-16 | 0.5 | hatches on a random tick |
| Honey Block | 15 | 0 | slows entities, sticks to pistons |
| Decorated Pot | 15-16 | 0 | shatters when hit by a projectile; non-ticking block entity |
| Dragon Egg | 15-16 | 3 | teleports when hit, so it cannot be mined at all |

Dragon Egg is listed only to rule it out: punching it moves it somewhere else
rather than starting to break it, which makes it useless as a mining stage.

That leaves Sniffer Egg as the one worth considering, and only once random ticks
are off - otherwise it hatches on its own. Every other near-cube in the game is
either opaque, has no collision, or is well under 14 pixels.

## What to actually use

**Stained glass.** Sixteen colours, each with its own blockstate and model file,
so each is skinned independently. No block entity, no random ticks, no entity
behaviour - `isValidSpawn`, `isRedstoneConductor`, `isSuffocating` and
`isViewBlocking` are all set to never, so standing inside one does nothing.
Add `glass` and `tinted_glass` and that is 18 blocks from one family.

Leaves are the next best and add another 12, at the cost of remembering
`persistent=true` on every placement - a leaf block placed without it disappears
on its own once it is more than six blocks from a log.

The block-entity four are the ones to avoid: their renderers draw on top of
whatever model is supplied, so the model override does not fully take.

## Blockstate properties as extra model slots

A block's state properties multiply how many models one block id can carry, but
only if **nothing in Java writes to the property**. Checked so far:

| property | safe? | why |
|---|---|---|
| leaves `persistent` | yes | only read by `decaying()`, and the only `removeBlock` is inside `randomTick` |
| leaves `distance` | **no** | `updateShape` schedules a tick on any neighbour change and `tick` overwrites it with `updateDistance` |
| `waterlogged` | **no** | the state itself is stable, but breaking the block leaves the water source behind |
| copper golem statue `pose` | **no** | right-clicking with anything but an axe cycles it |

The leaves case is the one to remember: turning random ticks off stops decay,
because decay is gated behind `isRandomlyTicking`. It does **not** stop the
distance rewrite, which runs on a *scheduled* tick instead - a different
mechanism that `randomTickSpeed 0` has no effect on.

## How many models each family is actually worth

| family | ids | usable states | total |
|---|---|---|---|
| Stained Glass + Glass + Tinted Glass | 18 | none | **18** |
| Leaves | 12 | `persistent` x2 | **24** |
| Copper Grate | 8 | - | **8** |
| Mangrove Roots | 1 | - | **1** |
| Sniffer Egg | 1 | - | **1** |

Roughly 50, and that is the ceiling. Leaves, mangrove roots and copper grate are
all waterloggable, which would double each of them, but breaking a waterlogged
block leaves the water source behind. Clearing it after the fact does not help:
a mined block is only noticed once its marker seed appears, so the water is
always there for at least a tick.

Copper Golem Statue would have been the richest source by far - 8 weathering
states x 4 facings x 4 poses - but right-clicking it cycles the pose, and the
handler runs before the held item's own use, so it swallows the click entirely.
There is no way to suppress that from a datapack.

## Two things that follow from picking one family

**All the glass variants share hardness 0.3**, so stages cut from that family all
mine at the same speed, and changing which colour a stage uses cannot silently
change its mining time. Different families cannot be mixed without retuning:
`ceil(hardness * 30 / speed)` means leaves at 0.2 mine noticeably faster than
copper grate at 3.

**Glass does not block skylight, leaves and mangrove roots do.** Relevant only
in a dimension with a sky; `derailed:game` has `has_skylight: false`, so it
makes no difference there.

## Which leaves to use, on sound grounds (parked)

Sound events come from the block's Java `SoundType`, so `sounds.json` can only
remap an event - it cannot tell which block rang it. That makes the choice of
leaf matter, because only two leaf sound types are exclusive to leaves:

| sound type | used by | nothing else? |
|---|---|---|
| `CHERRY_LEAVES` | cherry_leaves | yes |
| `AZALEA_LEAVES` | azalea_leaves, flowering_azalea_leaves | yes |
| `GRASS` | the other nine leaf types | no - 55 registrations |

Overriding `block.grass.*` to make leaves sound like wood also rewrites grass,
ferns, flowers and saplings. Overriding `block.cherry_leaves.*` and
`block.azalea_leaves.*` touches exactly three blocks.

**So use cherry and the two azaleas for the mineable stage 1**, where break and
hit sounds actually play. Stage 0 is unmineable and never produces either, so
its sound type does not matter and it can come from the `GRASS` group. That
covers the six leaf ids needed for six biomes with three clean ones and three
whose audio is never heard.

If a stage 0 block ever sounds like grass, that is a real signal: something has
put it into a tool's rules and made it minable.
