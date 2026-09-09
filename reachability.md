# Reachability ("Seen") — Design

> **Status:** Designed, not implemented. Decisions below are settled unless
> marked as an open question.

A map-wide record of which tiles a player can actually get to. Several problems
turn out to be the same problem underneath:

- **Placing into a pocket.** A tool put down somewhere the player cannot return
  to is a soft lock, and equipment is one-of-a-kind.
- **Mining trees from behind.** A tree should only be minable once the player
  can stand next to it, which depends on whether a path exists - not on whether
  a neighbouring tile happens to be clear.
- Anything later that needs "can a player get here": spawn points, where the
  train may pass, where a thrown resource may land.

## What "seen" means

**A tile is seen when a player can stand on it.** Not "is air", and not "is air
connected to spawn" - those mark tiles above walls and inside one-block gaps
that nobody can occupy.

A tile is standable when it has support below and room for the player above.
Two standable tiles are connected when they are orthogonally adjacent and
differ by at most one in height, which is what a player can step or jump.

This distinction is the whole design. A pure air flood is easier to write and
answers the wrong question.

## Breadth-first

**Use BFS, one wave per tick.** Depth-first is the wrong shape for mcfunction:

- DFS needs a stack, and the only way to get one is nested `function` calls.
  Every level counts against the per-tick command budget, so a deep fill is one
  enormous spike and risks hitting the limit outright.
- BFS is naturally set-shaped. `execute as @e[tag=dr_fill_frontier]` processes a
  whole wave at once, which is how selectors want to be used.
- A wave per tick spreads the cost. Generation-time fill can take as many ticks
  as it needs, and the work per tick is bounded by the frontier, not the map.
- Progress is observable: an empty frontier means done. DFS gives no such
  signal without extra bookkeeping.

## Marking

**State lives in blocks. Only the frontier is entities.**

Blocks already distinguish seen from unseen, so no separate structure is needed:

| tile | unseen | seen |
|---|---|---|
| empty | `cave_air` | `air` |
| resource | the unbreakable stage 0 block | stage 1 |

`cave_air` is the right marker because it *is* air to every system - it carries
no collision, no light, no model, and sits in `#minecraft:air` next to `air` and
`void_air` - while `execute if block ~ ~ ~ cave_air` still tells the two apart.
`structure_void` and `light` are real blocks imitating nothing, and everything
that tests for air has to be taught about them.

Resource tiles come out of it for free: the flood reaching a tree is exactly the
condition for promoting stage 0 to stage 1, which is a better test than "did a
neighbour get cleared".

**Seen and unseen are the same mark**, so there is nothing to keep in step - the
question "have I been here" is answered by which block is in the tile.

### Why the frontier still needs entities

Blocks can *store* state but cannot be *enumerated*. Finding this tick's
frontier without entities means sweeping the play area, which is the cost the
whole design exists to avoid. So the frontier is marker entities: transient,
one wave's worth, deleted as they are processed. They never accumulate, unlike
one marker per tile.

### Which air to write

Every `setblock ~ ~ ~ air` now means "mark this tile seen". Three already exist:

```
item/_new_tool_placement.mcfunction
placement/update_placement.mcfunction
placement/_remove_placement_section.mcfunction
```

All three clear tiles that were already seen, so they are correct as they stand,
but the choice has to be deliberate from here. A `setblock air` in an unseen
region silently punches a hole in the map.

## The algorithm

Seed a frontier marker at the player spawn tile, then each tick:

1. For every frontier marker, mark its tile seen - `cave_air` becomes `air`, a
   stage 0 resource becomes stage 1.
2. If the tile is not standable, stop there. It is still seen, it just does not
   spread. This is what stops the fill leaking into walls and through trees.
3. Otherwise, for each of the four orthogonal neighbours at the same height and
   one step up or down, if that tile is still unseen, put a frontier marker on
   it.
4. Kill the processed frontier markers. The next wave becomes the current one.

Done when the frontier is empty.

## Keeping it current

When a block is mined, seed a frontier marker on the tile that opened up and let
the same wave logic run. Most breaks wet nothing or one tile; the expensive case
is holing into a sealed region, and that cost is paid once, proportional to the
region.

Total work over a match is bounded by the number of tiles, because **a tile is
seen exactly once and never revisited.**

## The monotonic assumption

The fill only ever adds. Nothing un-sees a tile, because withdrawing
reachability would need a full recompute - you cannot tell locally whether a
newly placed block cut the only path.

That is sound here because **the map only opens up**: trees and rock are mined
away and never regrow, and placements sit on tiles without sealing them (a
placement's base block is a few pixels tall and does not block movement).

If something later can seal a corridor - a built wall, a closing door - this
assumption breaks and that feature needs a recompute of the affected region.

## Open questions

- **Fill volume.** A flat play area only needs the walkable surface, roughly one
  tile per column. Worth confirming the map is flat enough that height can be
  derived rather than searched, since that decides whether this is a 2D or a 3D
  fill.
- **Where the map ends.** With `cave_air` as the unseen mark, generation has to
  write it into every empty tile of the play area, and the fill needs some way
  to know it has run off the edge. Filling to the boundary and leaving plain
  `air` outside is one answer; a border of solid blocks is another.
- **Diagonals.** Orthogonal only, matching the tree-unlock rule. Players can
  move diagonally, so a one-tile diagonal gap is walkable but would not be
  filled through. Probably fine, but it is a deliberate difference from what the
  player can physically do.
