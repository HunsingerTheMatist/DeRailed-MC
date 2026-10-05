# Trains

Written 2026-10-04. How a train moves along its track and what it is made of.
`train/` holds the system; `dev/train/test` lays a looping test track and puts a
train on it, and `dev/train/clear` takes every train away.

## The path

A train runs along storage `derailed:train`, path `path`: a list of tiles, each
`{x, z, din, dout, len}`, its middle and its length in thousandths of a block
and the ways it is come into and left by, 0 north, 1 east, 2 south and 3 west.
`y` is the height the train runs at, 0.2 above the rails.

A straight tile runs from the middle of one edge to the middle of the other,
3000 long. A corner is one quarter circle round the tile's corner inside the
turn, radius 1.5, 2356 long. A tile counts as a corner wherever its ways in and
out differ.

Tiles drop off the back of the path once every axle is two tiles past them.
Where `loop` holds a copy of a looped track, another round of it goes on the end
whenever the front comes within 16 tiles of it.

## Axles

Every piece has two axle markers, `dr_axle` with `dr_axle_front` or
`dr_axle_back`, each holding the tile it is on (`dr_ai`), how far into it
(`dr_ad`) and that tile's details. Each tick every axle moves `$TrainSpeed`
along, 15 by default, 0.1 tiles a second, onto the next tile once it runs off
its own. A corner's arc is stood on with `execute rotated` and `^ ^ ^1.5` from
its corner, so no sine is ever worked out.

The axles sit where each model's wheels are, so the body swings round a curve
as a real one does: the engine's at its front and back driving wheels, 1.2 either
way of its display once the model's nudge is counted, and the wagons' at ±0.6.

## Pieces

A piece's item display stands on the line between its axles, midway, facing its
back axle, since an item display draws its item turned half round. Its parts go
round it by local coordinates; where it faces a square way they go by plain
offsets instead, since local coordinates come from a table of sines that is out
by up to a ten-thousandth of a block (`_square`).

The client is sent an entity's facing in 256 steps a turn, which jitters, so a
piece's model is turned through its transformation's `left_rotation` and its
own facing is set back to 0 every tick (`_turn`).

| piece | shulkers (2.5) | interactions | wheels |
| --- | --- | --- | --- |
| engine | 2, each riding a display at ±1.5 | one on each of those, 2.51, and one riding the model | three big, one small pair |
| supply wagon | 1, riding the model | four at the corners, 1.255 by 2.51 | two big |
| water wagon | 1, riding the model | one riding the model, 2.51 | two big |

A shulker moves only by riding something, since one standing alone is moved to
the middle of a block every time it moves. Every part of a piece shares its id,
`dr_tid`.

## Wheels

Each pair of wheels is a display of its own, `train_big_wheels` or
`train_small_wheels`, turned the way its piece faces by `left_rotation` and
rolled about its axle by `right_rotation`, by how far the piece has gone
(`dr_spin`): a radian for every 0.45 gone, the big wheels' radius, which the small
ones turn at too. `utils/bake_structure_model.py` cuts the wheels out of the
bodies with `--cut`, which prints where each axle lies, and bakes them centred
with `--middle`.

## Keeping players out

A player a shulker moves into is moved back out, just past the side of its box
they are nearest, once more than 0.1 in, since the box they see and walk against
stands where it stood a tick before (`_push`).

Pink glass panes, drawn as nothing by the resource pack, stand in the two blocks
over every straight rail the train covers all of, so nothing gets between its
pieces. A marker at each end of the train keeps them: the front one lays them
over a block once it has passed all of it and the back one clears them as soon
as it comes onto one. A player squeezed under a pane, where there is room to
crawl, is moved out from under it across the way it runs (`_push_pane`).
