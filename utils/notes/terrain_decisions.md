# DeRailed Terrain: The Decisions

Written 2026-09-22. This is the companion to `terrain_generation.md`, which says
how each piece is built. This one says what a section is meant to be, what was
decided along the way, and why. Where a number is still provisional it says so.

## What a section is

The map is a row of **sections**, each 32 tiles east to west and 16 north to
south, built one after another going east. The train comes in on a row of the
west edge, where the section before let it out, and leaves by a row of the east
edge that the section chose. Nothing about a section is finished by the section
after it: once built, it is never written to again.

Terrain is made of **regions**, not tiles. Eighteen seeds are scattered, each
grows a blob, and every blob is one kind throughout: ground, wood, iron, water or
rock. Big forests and rock fields are two or three blobs that happen to touch.
The density is one seed to about 28 tiles, so regions are the size they were
at every earlier section size, and a section always looks like a section.

A region holds together edge to edge. Growth never leaves a tile hanging off a
corner of its region, and a tile a river cuts off from its region is handed to
the region beside it, so a lone tile of one kind never sits inside another.

Regions cross the seam. Whatever blob was cut off by the eastern edge of one
section carries on into the next, so a forest is not sliced flat at every 32
tiles. A carried region keeps its kind, and the section it enters draws that much
less of that kind for itself.

## No corridor, and a wall

Nothing is reserved for the track. The section picks the row it will leave by,
leaning toward the top and bottom edges so that the track wanders up and down
the map over a run rather than holding a line, and the terrain is drawn without
regard to it. Where the track can go is settled afterwards: rock is not
impassable but very expensive, a thousand a tile, so the cheapest way across
only ever goes through rock where no way round it exists, and where it does, that
rock is **cut out**, leaving a passage one tile wide. Water at both ends of a
cut, river or lake either, runs through the whole of it as river; a river at
one end gives way to the land at the other, ground, wood or iron. Any other
cut is filled in from both ends at once, each tile becoming whatever terrain
other than rock or river is nearest, so the passage takes the terrain it opens
onto at each end. Rock cut to open a pinch up never becomes river. The exit
tile
is kept off rock where any row of the east edge is clear of it, so a section
never has to dig in at its very edge for want of a better row.

On hard that is made to happen. Once the regions have grown, a **wall** of rock
is run from the north border to the south, seed to seed, one region thick and
meandering wherever the seeds lead it, with every region on the way from one
seed to the next taken into it, so that it has no gap and reaches both borders.
Every hard section's route has to cut through it somewhere, and the cut, one
tile wide with rock either side, is the pinch hard asks for.

## Rivers

Rivers run **north to south**, on the boundaries between regions, so every
route across has to cross one. They never come in from or leave by a seam, so
each section's rivers are its own and the seam rule holds.

Every section gets a first river of at least 20 corners. If that river came to
fewer than 40, it gets a second one as well, starting from the same border at
least six columns away and held to whatever brings the pair to 40 between them,
never less than 10, and allowed to end by running into the first. A river that
can find no way out from five different starts lays the longest line it found
and ends in a lake, so a river never just stops on dry ground.

Two crossings a section, or one long one, is the amount of bridging the section
is meant to ask for.

## Difficulty

Difficulty is three **tiers**, easy, medium and hard, chosen before a section is
built. A tier decides two things: what the regions are drawn as, and what a
section has to cost.

### What a route costs

The measure of a section is **what the cheapest way across costs a rail**. Each
tile costs something to lay track through - ground 1, wood or iron 2, water 4,
rock 1000 - and the cheapest route from entry to exit is found over the finished
terrain, then measured again over what it cut if it had to cut through rock. Its cost is divided by its length in rails, because the time the players
get is the rails they lay: a zig-zag route is not harder, it just takes longer
and buys the time to match. On top of that, every rail past the 32 of a straight
crossing adds one percent, since a longer section is more rails out of the same
supply.

A section is accepted when that figure lies inside the tier's band. Hard's band
of 2.65 to 3.30 comes from measured sections. **Easy's and medium's are
placeholders** until a batch run on each has shown where they land. A section
outside its band redraws its kinds and tries again, up to five times, and then
ships as it is and is counted.

### How pinched the train is

Cost per rail says how much work the route is. It says nothing about the
players getting round the train, which is a solid body two long and one wide
that nobody can pass through. So the route is also scored for **pinching**:
slide that box along the track, standing on each cell and the one ahead of it,
and note where rock closes both its sides at once; at a station it stands on
the last rail and the station's first as well. A run of pinched positions
costs its length cubed, so one long squeeze
counts far more than the same length in pieces, and the section's pinch score
is the sum over its runs. Only rock counts as a wall, since the players can
clear anything else, and the map's edges count as rock too: nobody gets round
the train past the north or south edge, and what lies past the east edge is not
built yet.

Each tier has a ceiling for that score, and hard has a floor: easy allows none,
medium two single rows of rock either side far enough apart not to touch, hard
anything from one such row up to a corridor five long. A section over its ceiling is not
rejected: the rock beside its worst run is cut back until it passes, the same
cutting the route uses to get through rock at all. A hard section under its
floor rerolls its kinds like a cheap one.

This replaces the idea of a pinch as a property of a tile, which asks whether
a tile is the only local link between two open areas. That is a question about
the map; ours is a question about the route, which is the only place the train
ever is.

### A second way round

The players have to be able to get past the train, so every section also has
a **second way across**, found the way the original game checks for one: from
the entry to the exit, keeping off every cell of the route where the train is
pinched, free to use the rest of it, and staying close, since a tile on the
route or beside it is free and any other tile counts one against it. Where the
original threw a section away for want of such a way, ours cuts one: rock is
priced at 16 of those tiles, so the cut comes only where the way round would
stray more than fifteen, a little tighter than the original's twenty, and
never within four steps along the grid of one of the route's pinch points, so
that the two routes' pinches stay apart with rock between them. A section
where even that finds no second way is rerolled, since nothing
short of new terrain can give it one, though that reroll is switched off while
the case is being looked at. The second way is judged for pinching like
the first and opened up the same way, but never for cost, and on hard it is not
asked to pinch. It is drawn purple beside the route's red, pink where the two
share a tile.

### Enough to build with

A section has to hold what its routes need. Every rail is a wood and an iron,
every tile of water under a route is a bridge, one wood, and the section is
held to the costlier of its two routes, with a fifth to spare. What counts is
what the players can reach from the route without crossing rock, and a
resource behind water is charged the bridge it takes to get there, once,
cheapest resources first. The resources also have to come along steadily,
not just add up: any thirty columns of the map, wherever they are taken and
whichever sections they fall across, hold at least two regions of wood and
two of iron within reach, so a section that ends in a forest is not followed
by one whose forest is at its far end. A stretch found wanting has a region
of the missing kind swapped in from elsewhere in the section, trading kinds
with a region there, so the section keeps its mix and only the placing
changes. A section that comes up short is not
thrown away: a region is repainted as the missing kind, first one of the
other resource that can be spared, then ground, then water, and never rock, a
wall, a lake or a region the route runs through. This stands in for the
original's supply check, which was a flow through the terrain with a limit on
what a narrow gap could carry; reachability with bridges is the part that
decides sections.

### What regions are drawn as

Each tier has a table of weights:

| tier | ground | rock | wood | iron | water |
|---|---|---|---|---|---|
| easy | 45 | 15 | 15 | 15 | 10 |
| medium | 35 | 21 | 18 | 18 | 9 |
| hard | 0 | 43 | 14 | 14 | 29 |

Easy is mostly open ground. Medium is the base mix. Hard has no ground at all,
so every tile of a route costs at least 2, most of the rest is rock and water,
and the wall runs through it.

### Why the draw is not a plain roll

Rolling each seed on its own from those tables gave sections that ran away: a
hard section came out with ten iron regions of eighteen, with every carried row
iron as well. That is a one-in-ninety draw, and there are a lot of sections.

So each section draws from a **bag**. The tier's weights go in, ten thousand
between them, and every draw takes half a seed's share off the kind drawn and
hands the same amount out to the other kinds in the tier's own ratios. A kind
drawn often gets less likely; a kind drawn too often goes into debt and sits out
until the others' draws have paid it back, which for a rare kind is most of the
bag and for a common one a few picks. Half a share was chosen over a whole one
on purpose: a whole share pins every count to its target and the randomness is
gone, half lets sections lean one way while keeping any kind from running off.
Modelled over 200,000 hard sections, seven or more iron went from one section
in 22 to one in 67, and eight or more from one in 91 to one in 1000, while six
still came up one section in eleven.

Underneath the bag sit **floors**: at least 3 wood, 3 iron and 2 water in every
section, and 3 rock, or 4 on hard. They are met by holding back the last seeds
drawn for whatever is still owed, never by changing a seed after the fact, and
with the bag in place they rarely have to act.

## Prefabs

Decided 2026-09-24 and built 2026-09-25. A **prefab** is a stamp of tiles
placed before anything grows, and nothing else in the generator may change a
tile of it: seeds keep out of it, regions stop at its edge, the wall never
takes it, rivers never carve it, cuts never touch it, the stray sweep and the
repaints leave it alone. Its tiles carry a block of their own on the region
layers, so its edge is a boundary like any other and every check can tell it
at a glance.

The first prefab is the **station**, which every section ends in and which
reaches across the seam into the section after:

```
              x=28   x=29   x=30   x=31  ‖  x=0    x=1
  row r-1     [ - ]  [ H ]  [ H ]  [ . ] ‖ [ . ]  [ - ]
  row r  ══>  [ . ]  [ = ]  [ S ]  [ ¬ ] ‖ [ . ]  [ . ]  ══>
  row r+1     [ - ]  [ . ]  [ . ]  [ . ] ‖ [ . ]  [ - ]
  row r+2     [ - ]  [ . ]  [ . ]  [ . ] ‖ [ - ]  [ - ]
```

Row r is the rail row, the row the track leaves by and the section after
comes in on, kept between rows 1 and 13 so the piece fits. Above its first two
rails stands the building, which cannot be walked, and above the buffer stop
open ground; below it two rows of open ground; west of it one tile of yard;
and east of it, in the section after, a yard two long on
the rail row and one tile on each row beside it. Every tile of it but the
building is open ground the players may walk and build on, so the track may
come onto the station's first rail from the yard tile west of it or from the
ground south of it, and leave its buffer stop east into the yard or south
into the ground below. Both routes end on the last rail the players lay,
whichever of those two tiles beside the first rail the flood reaches first,
and begin on column 0 of the entry row: leaving the buffer stop south lays
the same number of rails to reach the same yard tile as leaving it east, so
the flood from column 0 prices that way as well. A station's three rails are
neither rails to lay nor route to measure, and no route ever runs over them.
Across the seam the station reads as ground and spreads as ground. The yard
is what keeps water and rock off
the tiles
where the track leaves one section and enters the next, and what gives the
second route open ground to step off the rail on before it meets whatever
grew beside the yard.

Rivers go round prefabs, never through them. A river's corners can be turned
into tiles on any of the four sides of the corner, and each choice gives the
same river shifted a tile, still one wide and still joined; the first choice
whose tiles touch no prefab is kept. A line with no such choice is given up:
one that had reached an exit goes back to its last choice as at a dead end,
and a longest line falling back is not laid at all, since laying it shifted
is the only thing that could have saved it. No choice may put water across the
seam into the section before; column 0 itself is as open to water as it was.

## Placeholders and open questions

- The easy and medium cost bands are guesses until measured, and hard's is
  switched off while it is measured afresh over the wall and the cuts
- **The second way across must always exist, and must always go round the
  first route's pinch points.** That is a requirement, not a preference, and
  it is not met yet: a section still ships without one where the first route
  is walled in by its own pinches, most often on hard. Repainting cannot mend
  that, since the trouble is the shape of the rock. To be settled once the
  prefabs are in, since a station piece round each seam removes the case where
  the entry's own approach is pinched. The options on the table for what a
  section does when the second way fails: throw the whole section out and
  scatter afresh; keep the seeds but lay the wall and the rivers again; try the
  kinds once or twice more before either of those; or tell an easy failure from
  a hard one and go straight to the big reroll on a hard one, the tell being
  something like the wall or the pinches sitting against the entry or the exit
- What is known about those fallbacks so far, from ten test runs on
  2026-09-24: seven of the ten hard sections hit a missing second way on some
  attempt; the kinds reroll cleared it in four, three at the first retry and
  one at the second, and never in the other three, which spent two to four
  retries for nothing. So a retry that works, works at once, and after two
  misses more are wasted. Costs are unknown: nothing has been timed since the
  least-cost flood, the wall and the second route went in. To settle it: time
  each kind of reroll under the profiler with the bench harness, a kinds
  reroll being kinds, paint, validate and the second route, a wall-and-rivers
  redo adding the wall, the rivers and the strays, and a full reroll adding
  scatter, grow and the seam; then, with the reroll switched on and the
  attempt cap raised, count over fifty or so hard sections which retry clears
  the case and whether it is ever cleared, once for each kind of reroll. Cost
  per usable section is each policy's cost times the attempts it needs, and a
  full reroll may well win despite costing most per attempt. Whether the wall
  is what stopped the second way is cheap to read when the flood gives up: the
  reached cells still carry their arrows, so a scan finds the rock the front
  stopped against, and its region on y0 says whether it is a wall seed's
- Nothing has been profiled since the sections were 35 by 20 with one river and
  a depth-first flood. The least-cost flood and the bag both cost more than what
  they replaced, and how much is not known
- The bag and the floors have been modelled, not yet watched over many sections
  in the game
- There is no hard cap on how many regions of a kind a section can hold, only
  the bag's thin tail. A cap would be a few lines if the tail ever shows
- The wall cannot take in a region carried over the seam, which keeps its kind,
  so a wall laid through one has a hole; it is laid again from another column,
  up to four times, and the report counts any hole left
- Sections are placeholder blocks in a test area, built in one go. Real blocks,
  a queue spread over ticks, and stations are all still to come
