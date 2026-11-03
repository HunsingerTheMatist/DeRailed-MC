# Trains

Written 2026-10-04. How a train moves along its track and what it is made of.
`train/` holds the system; `dev/train/test {team:1}` lays a looping test track
and puts that team's train on it, `dev/train/test_both` lays one for each team
side by side, and `dev/train/clear {team:1}` takes a team's train away.

## The path

A train runs along its team's path, in storage `derailed:train`, `t1.path` for
red and `t2.path` for blue: a list of tiles, each `{x, z, din, dout, len}`, its
middle and its length in thousandths of a block and the ways it is come into
and left by, 0 north, 1 east, 2 south and 3 west. The team's `y` beside it is
the height the train runs at, 0.2 above the rails.

A straight tile runs from the middle of one edge to the middle of the other,
3000 long. A corner is one quarter circle round the tile's corner inside the
turn, radius 1.5, 2356 long. A tile counts as a corner wherever its ways in and
out differ.

Tiles drop off the back of the path once every axle of the team is two tiles
past them. Where the team's `loop` holds a copy of a looped track, another round
of it goes on the end whenever the front comes within 16 tiles of it.

## Teams

There are two teams, the vanilla teams `dr_red` and `dr_blue`, made by `load`.
`dr_team` holds 1 for red, 2 for blue and 0 for none: on each player, from the
vanilla team they are on every tick (`player/team`), and on everything that
belongs to a team: every part of its train, its axles and the markers at its
ends, the end of its track, its next tiles and its track tiles. A piece is
spawned for the team in `#train_team`. A player only ever acts on their own
team's train and track: a click on another team's train does nothing at all,
not even the refusal sound, and a player on no team has no train.

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
| engine | 2, each riding a display at ±1.5 | one on each of those, 2.51 by 2.81, and one riding the model, 0.75 by 2.81 | three big, one small pair |
| supply wagon | 1, riding the model | one riding the model, 2.51 by 2.81 | two big |
| water wagon | 1, riding the model | one riding the model, 2.51 by 2.81 | two big |
| crafting wagon | 1, riding the model | one riding the model, 2.51 by 2.81 | two big |

A shulker moves only by riding something, since one standing alone is moved to
the middle of a block every time it moves. Each rides an interaction 0 wide
and 0.3 tall on the display, since an interaction carries its passengers at its
own height, so its box stands 0.3 to 2.8 above the display and a player
carrying something cannot jump onto it from the ground (see
[player_attributes.md](player_attributes.md)). The interactions are 0.3 taller
than the box to match. Every part of a piece shares its id, `dr_tid`.

## Wheels

Each pair of wheels is a display of its own, `train_big_wheels` or
`train_small_wheels`, turned the way its piece faces by `left_rotation` and
rolled about its axle by `right_rotation`, by how far the piece has gone
(`dr_spin`): a radian for every 0.45 gone, the big wheels' radius, which the small
ones turn at too. `utils/bake_structure_model.py` cuts the wheels out of the
bodies with `--cut`, which prints where each axle lies, and bakes them centred
with `--middle`.

## The water wagon's tank

The water wagon holds its train's water as scores on its display:
`dr_water_used`, the ticks of water it has used, and `dr_water_cap`, how many
it holds; it sets off with none used and `dr_water_cap` at `$WaterTicks`, 2400
by default, and uses one a tick, catching fire once it has used all of it.
Raising `dr_water_cap` leaves the water already used as it is. Refilling is not
built yet: it is to set `dr_water_used` back to 0, and only once the train has
used `$RefillWait`, 500 by default.

Its tank is baked as white concrete taking the item's first tint
(`--tint light_blue_concrete=white_concrete`), read from its
`custom_model_data` `colors[0]`, so its colour is set by one data change. The
tints are baked into `load` as a list of 101, one for each hundredth of water
used, from the one that makes it look like light blue concrete, full, to the
one that makes it look like red concrete, dry, mixed in linear light. The
hundredths of its water used pick one, drawn whenever they change
(`_water_shade`), so the tank starts to redden as soon as it is refilled.

## Supply and crafting

What the wagons hold are scores on their displays too: `dr_wood` and `dr_iron`
on the supply wagon, up to `$SupplyCap` of each, and `dr_rails` on the crafting
wagon, up to `$RailCap`, 3 each by default.

Clicking a piece of the train goes to `train/click`. An empty hand clicking
the supply wagon takes whichever of wood and iron it holds, or with both, wood
from its front half and iron from its back half, as many as a hand holds; wood
or iron in hand goes in wherever it is clicked, as many as there is room for.
The crafting wagon gives its rails to a hand that is empty or holds rails, as
many as it has room for. Sneaking narrows any of these to one, and anything
else is refused, as is any click on the engine or the water wagon.

Auto pickup tops a partly full hand up from the train as well as from piles,
after the piles (`train/auto_take`): wood or iron from the supply wagon and
rails from the crafting wagon, for a player standing against the wagon, whose
interaction a box 2.5 blocks across and a block tall from 3 pixels over their
feet touches. A player who puts a resource into a wagon or takes one out by
clicking is held off auto pickup of that resource from the train, tagged
`dr_hold_wood`, `dr_hold_iron` or `dr_hold_rail`, until they are more than 3
blocks past the side of the wagon holding it, 4.25 from its middle
(`train/release_holds`), as a pile put down is held for its player.

The supply wagon has one interaction, the size of the crafting wagon's, so it
covers the wagon's shulker from every side however the wagon is turned; boxes
round its corners would turn with it while the shulker's box does not, and
leave the shulker's corners out to take the click. Which half was clicked is
found from the aim instead (`train/_supply_aim`): it is followed from the
player's eyes to the first point inside the interaction, and the pile nearest
that point, each scored `dr_item` with what it draws, says which; the two
piles stand on the wagon's middle line either side of its middle, so the
halves turn with it. The aim goes a twentieth of a block at a
time, so one that only grazes a corner of the interaction can pass through
it unseen; that click does nothing.

Every tick (`train/craft`, run as each crafting wagon), while its team's supply
wagon holds a wood and an iron and the crafting wagon has room for another
rail, a rail is made
every `$CraftTicks`, 64 by default, 3.2 seconds, taking the wood and the iron
from the supply wagon only as it joins the rails. A rail being made stops
when either runs out, and starts over once both are back; `dr_craft_left` on
the crafting wagon counts down the ticks left, 0 while idle.

Each wagon draws what it holds as piles on its bed, at 0.8 of a pile's size:
the wood over the front half of the supply wagon's bed, the iron over the back
half and the rails in the middle of the crafting wagon's, a layer for each, up
to three (`train/draw_loads`). They go round their wagon by local coordinates
and turn with it through the same `left_rotation`.

## Keeping players out

A player a shulker moves into is moved back out, just past the side of its box
they are nearest, once more than 0.1 in, since the box they see and walk against
stands where it stood a tick before (`_push`). The box is taken as 0.3 to 2.8
above its display, where the shulker rides.

Pink glass panes, drawn as nothing by the resource pack, stand in the two blocks
over every straight rail the train covers all of, so nothing gets between its
pieces. A marker at each end of the train keeps them: the front one lays them
over a block once it has passed all of it and the back one clears them as soon
as it comes onto one. A player squeezed under a pane, where there is room to
crawl, is moved out from under it across the way it runs (`_push_pane`).
