# Tracking the End of the Track

Written 2026-09-18. Laying rails is built (see "Laying a rail" below); taking
the last rail back, and its interaction, are not yet.

## Laying a rail

Clicking with rails on the tile beside the end of the track, any but the one
the track came in from, lays a rail there (`track/try_lay`); anywhere else the
rail goes down as a pile. Tiles are three blocks across from the map's corner
at x1100 z0, and a tile's rail is a rail on its middle block and a powered rail
on each of the two edges it runs through (`track/lay_rails`).

Every rail is an iron trapdoor, which gives the track a 3 pixel hitbox and is
the one trapdoor a hand cannot open. The resource pack draws each of seven of
its states as a rail:

| `powered` | `facing` | drawn as |
|---|---|---|
| false | north | straight, north to south |
| false | east | straight, east to west |
| false | south | powered rail, drawn as nothing |
| true | north | turning south to east |
| true | east | turning south to west |
| true | south | turning north to west |
| true | west | turning north to east |

A block update beside one would set `powered` back to match the redstone round
it, so everything near the track is placed `strict`. The station's rails in
`station.nbt` are the same trapdoors.

- **Open ground.** The new tile's three rail blocks, and the end tile's edge
  block its rail turns through, must each be free to place in, over a whole
  floor block. Where any is not (water, an unchopped tree, unmined iron, rock)
  the click places a pile instead.
- **Track tiles.** Every tile with a rail has a marker tagged `dr_track_tile` in
  the middle of its middle block; the station's two rail tiles get theirs when
  the map is built. No pile ever stands on a track tile: `item/place_on_floor`,
  behind clicking, dropping and every search, refuses any spot with one of
  those markers in the three by three columns round it, within three blocks up
  or down. Those columns always hold the middle of the spot's own tile and no
  other's, at whatever height the spot is, which a distance from the spot
  would not: a spot a block above the marker on its tile's corner is √3 away.
- **Piles on the new tile** are moved off it first, each whole onto a spot round
  it by the same search dropping items uses (`track/shift_aside`). A pile of
  more than a hand holds (`$HandCap`, 3 by default) is never moved, so a tile
  with one refuses the rail, though the ghost still shows there. The new
  tile's marker goes down before they move, so none of them can land anywhere on
  it, and is taken up again if they cannot all move. The moves are planned in
  scores alone: a new spot is a reserved placement with no displays or
  collision, a pile added to only has its count raised, and the piles being
  moved are passed over by the search. Once every pile has somewhere to go the
  plan is drawn and the old piles emptied; if any has nowhere, the counts come
  back off, the reserved spots go, and nothing in the world has changed, so the
  click fails.
- **The search** is the same one dropping items uses (`item/place_near`, see
  [pile_search.md](pile_search.md)), so a pile may be split across spots.
- **The new rail** runs straight on. The end tile's rail is turned toward it
  where the track turns, and its tile of the train's path gets the new way out
  and a corner's length.
- **The path** gets the new tile on its end. Axles on the changed tile take up
  its new line at once and roll on to the next tile where they are further in
  than its new length.
- **The end marker** `dr_track_end` moves onto the new tile's middle block, and
  its position is appended to `rails`. It faces the way on while a rail is laid,
  so the blocks along that way are `^ ^ ^1` to `^ ^ ^4` from it.

- **Next tiles.** Each tile beside the end that the next rail could go on has a
  marker tagged `dr_track_next` in the middle of its middle block, facing the
  way on to it (`track/_mark_next`). They are put down again whenever the end
  moves and by `dev/track/start`.

## The ghost rail

Every 5 ticks (`track/ghost_tick`), each player holding rails has their aim
followed from their eyes a tenth of a block at a time out to 4.5 blocks, the
reach for blocks and entities alike. An interaction or another player met on the
way takes the click, so nothing shows. Otherwise the first block met is the one
clicked: the block before it where it has collision, the block itself where it
has none, like a flower.

Blocks are tested whole, so some are passed through (`#derailed:ray_passable`):

- **Air and water.**
- **Flowers, grass, carpets and the retextured buttons**, which only stand in
  the block over the ground the aim lands on anyway.
- **A pile's cakes**, since a cake's block reaches out past the pile's
  interaction, which the game itself clicks first as the cake's own shape is
  inside it.

A slab stops the aim only in its full half. A point is in a bottom slab's empty
top half where half a block up from it is out of the slab's block, and in a top
slab's empty bottom half where half a block down is; two slabs stacked the same
way read as solid between them.

If that block's tile has a `dr_track_next` marker, and the rail laid there would
stand on open ground, the tile shows a see-through rail: an item display of
`derailed:rail_ghost`, the rail's model with its texture at half opacity, facing
the way on. One ghost stands on a tile however many players aim at it. Every
ghost is tagged stale before the aims are followed, a ghost still aimed at loses
the tag, and those still stale after are removed. Laying a rail removes the ghost
on that tile at once.

`dev/track/start` starts a track of one straight rail on the tile the player
stands on, running the way they face, and takes every train away.

## The mechanic

Rails go down one at a time and only at the end of the track. The rail just
placed can be taken back again. Rails the train has already passed cannot.

So the only edits ever made are at the very end: push one, pop one. That is a
stack, and the implementation should be a stack rather than something that tries
to rediscover the order later.

## Why not work it out from the rails themselves

Reading the track's shape to find "which neighbour is my predecessor" looks
possible and is not. A later stretch of track can run alongside an earlier one
without ever closing a loop - right three, down one, left three puts the end rail
directly beside the start rail - so an end rail can have two neighbouring rails
with nothing in the block states to say which came first. Guarding with "the
track may not form a loop" does not cover it, since no loop was formed.

Per-rail markers would work, but they cost an entity per rail, need index
bookkeeping to stay ordered, and depend on the chunk staying loaded. A list in
storage keeps the order inherently, costs nothing per rail and persists.

## The data

Storage `derailed:track`, path `rails`: a list of positions, each one in `Pos`
format - three doubles at the block centre - so entries copy straight in and out
of an entity's `Pos` with no macro and no conversion.

- `rails[-1]` is the current end of the track
- `rails[0]` is the floor: the oldest rail that may still not be taken
- the list holds only the rails that are still removable

## The two entities

- a **marker** tagged `dr_track_end` - the placement anchor. It always sits on
  the end of the track, and placement is allowed on tiles within 1 of it
- an **interaction** tagged `dr_track_take` - the click target for taking the
  last rail back

They are split because the two affordances come and go separately: there is
always somewhere to place, but not always something to take. The interaction is
**parked below the map** rather than killed when nothing may be taken, which
keeps it out of both the click and the `distance=` tests.

Park it shallow. Entities are discarded once their Y drops below the dimension's
`min_y` minus 64, and `derailed:game` has `min_y` 0, so anything below **-64 is
deleted**. Around -20 is safely out of reach and safely above the line.

## The operations

Placing, after moving the anchor onto the new rail:

```mcfunction
data modify storage derailed:track rails append from entity @n[type=marker,tag=dr_track_end,distance=0..] Pos
```

Taking the last rail back:

```mcfunction
# nothing to take once the list is down to its floor entry
execute unless data storage derailed:track rails[1] run return fail

data modify entity @n[type=marker,tag=dr_track_end,distance=0..] Pos set from storage derailed:track rails[-2]
data remove storage derailed:track rails[-1]
```

Then move the interaction onto the new end, or park it if the list is now down to
its floor. A single rule is easier to keep right than scattered spawn and hide
logic: after **any** change to the list, the interaction belongs on the end if
`rails[1]` exists and below the map otherwise.

## What the command set gives us

All checked against 26.3 rather than assumed:

- **Negative indices work.** The path resolves `index < 0` as `size + index` and
  then bounds-checks it, so `[-1]` and `[-2]` are the last two entries. An index
  outside the list is simply **no match**: the command fails and changes nothing,
  which is what makes `execute unless data storage derailed:track rails[1]` a
  free "nothing to take" guard
- **`data remove ... rails[-1]`** pops the end
- **`data get` on a list returns its size**, so
  `execute store result score #track_left dr_var run data get storage derailed:track rails`
  is a free count of rails remaining - useful for warning that the train is about
  to run out
- **`data modify entity ... Pos set from storage ...`** moves an entity with no
  macro, but it does not always refresh the entity's tracked chunk section in the
  same tick, so a `distance=` selector can disagree for one tick. Taking a rail
  and placing the next one will not happen in the same tick, so this should not
  bite - but it is the first thing to suspect if something is off by exactly one
  tick

## Still to decide

- **Whether the train pops `rails[0]` as it advances.** If it does, the rule
  becomes "`rails[0]` is where the train is", everything behind the train is
  already gone from the list, and **no station reset is needed** - rails from
  before the last station are unremovable for the same reason as any other rail
  the train has passed. If it does not, the list needs clearing at each station,
  reseeded with the anchor's position as the new floor
- **Whether taking should also be refused when the train is next to the end**, so
  a rail cannot be pulled out from under it

## Gotchas

- Writing the list from the entity's `Pos` makes storage downstream of the
  entity, so a mispositioned anchor quietly poisons the history. Writing both
  from the same computed placement position avoids that
- Two players taking in the same tick would both pop. Funnel removals through one
  function
