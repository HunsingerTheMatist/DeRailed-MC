# Throwing

Written 2026-10-16. Pressing Q throws what is dropped as a pile through the air,
which lands as a pile, merges into piles of the same resource it touches, and
can be caught. `toss/` holds it.

## The throw

`item/event/item_dropped` hands the dropped count to `toss/throw`, run at the
player's eyes facing their aim. It summons an item display drawn as the pile
the items make, carrying an interaction the size of that pile (0.885 across, a
layer a resource, a block for the bucket and a flat box for the tools), which is
both the box it collides with and what a player clicks to catch it. The box is
centred on the eyes, and the items come off the player at once.

It goes along the full aim, pitch included, slower the more it holds, in
ten-thousandths of a block a tick, all in `dr_config`:

| thrown | score | default |
|---|---|---|
| 1, and every tool and the bucket | `$TossSpeed1` | 6000 |
| 2 | `$TossSpeed2` | 4500 |
| 3 or more | `$TossSpeed3` | 3000 |

On flat ground a single item goes about 7.9 blocks at best, aimed about 37
degrees up, two about 4.9 and three about 2.5. Straight up, a single item's
middle climbs about 3.6 blocks above the eyes.

## Flight

`toss/tick` moves every thrown pile each tick as a dropped item moves: 0.04 of a
block a tick faster down (`$TossGravity`), its velocity flown through Bookshelf's
`bs.move` (see below), then 98 hundredths of its speed kept (`$TossDrag`).

`bs.move` stops it against blocks, by their real shapes, and against anything
tagged `dr_hard`: players, and the piles' and the train's shulkers. It calls
`toss/_hit` with the face of the box that hit:

- **the bottom, coming down:** it has landed, and stops dead
- **the top, going up:** it stops rising
- **a side:** it stops going across either way, and falls

Its thrower is passed over, tagged `bs.move.omit` for its own move only, until
its box has cleared them; a throw at a wall right in front of them hits the
wall.

## Merging

After each move, any pile of the same resource its box touches takes as many as
it can (`toss/_merge`), the piles holding the most first, the nearest of those
holding as many. A pile's interaction is a little wider and taller than what
stops the thrown pile, so it touches once it has stopped against the pile. What
is left shrinks to fit and flies on, so one that hit the side of a full pile
falls past it.

## Landing

It comes down where it lands, where its bottom falls into water, or after 10
seconds in the air wherever it is (`toss/_land`). The items go through the pile
search from the block it rests in, and whatever finds nowhere is left as a pile
right there, whatever stands there.

In water, or resting on a player, the train or a pile of another item, it first
goes back against the way it was thrown, a quarter of a block at a time along
its longer way across, until it is out of the water or clear of what it rested
on, as far as 5 blocks, and comes down there instead. The way it was thrown is
the velocity across it set off with, kept in `dr_toss_vx` and `dr_toss_vz`,
since hitting things takes it out of `bs.vel`. Thrown straight up there is no
way back, and it comes down where it rests.

## Catching

Clicking a thrown pile's interaction catches it (`toss/catch`) where the hand is
empty or holds the same item with room for all of it, `$HandCap` at most;
nothing is swapped, so otherwise the catch is refused.

## Bookshelf

`bs.move` is the move module of [Bookshelf](https://github.com/mcbookshelf/bookshelf)
(MPL-2.0), kept unchanged in `vendor/bs.move/`, a data pack of its own with its
`bs.hitbox` and `bs.load` and the shared `load` convention, linked into a test
world beside `DeRailed`. `utils/build.py` folds it into the datapack zip, merging
the `minecraft:load` tag and adding its licence as `LICENSE-bs.move`. It keeps a
marker in a chunk it force-loads far out in the overworld, and leans on macros,
so its cost grows with how fast and how big what it moves is.

## Cost

Benched 2026-10-16 with `dev/bench/toss`: 20 single wood piles thrown level in
open air, then 10 ticks of flight each, in one tick. Under the profiler a move
cost about 0.5 ms, about 0.6 ms with its share of the time the profiler could
not place, and a throw about 1.3 ms once. The profiler inflates both several
times over, so a handful of piles in the air at once is a small part of a
tick. Most of a move is Bookshelf's own bookkeeping: a marker summoned and
teleported to its far chunk, positions read back from storage, and the blocks
along the move checked one by one. Hits cost more, since the callback runs and
Bookshelf checks again up to twice more that tick; that has not been benched.

`dr_hard` goes on players as they join and on piles and trains made from now
on, not on ones already in a world.
