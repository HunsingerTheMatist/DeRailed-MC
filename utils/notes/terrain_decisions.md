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
onto at each end, and becomes part of the region it copies, so that a region
repainted later takes its cuts with it instead of leaving a strip of what it
used to be. Rock cut to open a pinch up never becomes river. The exit
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

A section is accepted when that figure lies inside the tier's band, taken on
the cheapest way across once the second route has cut what it cuts, since that
is what the players can lay; the first route is only held to the floor, since
a first route over the ceiling can still have a cheaper way beside it. Medium's
band of 1.60 to 2.50 is the middle eighty percent of a batch measured on the
cheapest way, with the pieces in. Hard's of 2.20 to 3.00 was chosen from a
batch measured the same way, whose middle eighty percent ran from 2.07 to
2.87. The two overlap from 2.20 to 2.50: holding medium under hard's floor
would have turned away more than a quarter of medium's sections as too
expensive. **Easy's is a
placeholder** until a batch run on it has shown where it lands. A section
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
a **second way across**: from the entry to the exit, keeping off every cell of
the route where the train is pinched, and otherwise walking the route itself.
It leaves the route only to get round a pinch, and no detour may run more than
twenty tiles off it, since the point of the second way is that players caught
on the wrong side of the train can get round to the other side in good time.
Where a way round within that limit needs no rock cut, the one with the fewest
tiles off the route is taken; where none does, the one cutting the least rock
that still keeps within it; and where not even that can be had, the attempt is
rerolled, since the second way must always exist. An earlier version priced
each rock tile at sixteen tiles of straying and let the way stray as far as
that made cheapest, which let one second way run twenty-six tiles out and
back, and it wandered off the route even where there was nothing to go round,
since a tile beside the route cost the same as one on it. A section whose
first route pinches nowhere simply has the first route as its second. Rock is
never cut beside the route, since that is what pinches it, nor within four
steps along the grid of one of the route's pinch points, so that the two
routes' pinches stay apart with rock between them. The end cells
of a pinched run three or more long are left out of that distance, since
the second route only has to keep off them, and a zone round the ends of a
long run can wall in every way round it, most of all where the run ends at
the station. Nearly every section left with no second way had its first
route pinched right against an end, where the second route has to start or
finish on the very tile the pinch hems in. So the pinches against either end
are the first opened when a section is over its ceiling, from that end and
only as far as the ceiling needs, and when the second way is not found their
cells within two tiles of the end are opened and it is looked for again:
only when it is needed, and no further, so that as much pinch as can stay
does. A
section where even that finds no second way is rerolled, since nothing
short of new terrain can give it one. Drawing the kinds again was not enough
for that on hard, where the wall holds most of the rock in the way and stays
put across attempts: with the twenty-tile limit, eight sections in 99 used up
every attempt without a second way. So after two misses a section is built
again from its seeds for each attempt that follows, wall on hard, rivers and
stray sweep in their usual order, on every tier alike, rather than cutting into the no-cut zone or the rock
beside the route, which would give up what those rules protect. Laying only the
wall again would have left it laid after the rivers and the sweep, turning
round two things the usual order keeps: that no lake falls on the wall, and
that the sweep never takes a tile off it. The second way is judged for pinching like
the first and opened up the same way, but never for cost, and on hard it is not
asked to pinch. It is drawn purple beside the route's red, pink where the two
share a tile.

The rock the second way cuts is rock no longer, and the track can be laid over
it as well as walked. Measured over 97 hard sections, the second way came out
cheaper to lay than the first route in 31, every one of them where it had cut
rock, and by as much as half: a section judged at 143 could be crossed for 76,
under the band's floor. The players lay track wherever they like, so what a
section costs is the cheapest way across once everything is cut, and that is
what the band is held to. The section is flooded again over both routes' cuts
and rerolled if that way falls outside the band, rather than the second way
being kept costlier than the first, which would narrow the ways round a pinch it
has to choose from.

Water has to be within reach of wherever the track runs, so every tile of the
cheapest way across, which is where the track is likeliest to go, is held to
water within 25 steps. Only rock
keeps the players from water, so the steps are walked round rock and nothing
else, and water just over the seam counts, since the section before is
finished and the players can walk to it; the section after is not built yet
and cannot. It is judged on the section as it ships, after the repair, since a
swap can turn a lake into a forest.

### Enough to build with

A section has to hold what its routes need. Every rail is a wood and an iron,
every tile of water under a route is a bridge, one wood, and the section is
held to the costlier of its two routes, with a fifth to spare. What counts is
what the players can reach from the route without crossing rock, and a
resource behind water is charged the bridge it takes to get there, once,
cheapest resources first. The resources also have to come along steadily,
not just add up: any thirty columns of the map, wherever they are taken and
whichever sections they fall across, hold at least two regions' worth of wood
tiles and of iron tiles within reach, so a section that ends in a forest is
not followed by one whose forest is at its far end. It is counted in tiles
because counting regions by where their seed lies let a region count in full
for a window it barely touched and not at all for one it mostly filled; a
region's worth is the tiles a region averages, taken from the section's size.
A stretch found wanting, or a
section short overall, has regions swapped between kinds, which keeps the
section's mix, or repainted outright, and never rock, a wall, a lake or a
region the route runs through, except from wood to iron or iron to wood, which
the route pays the same for and so leaves its cost as it was judged. Nor is a
region taken from a kind already down to its floor: the floors are a promise
about the finished section, not only
about the draw, so repainting may move a kind down to its floor but never
under it. A section can only change its own regions, and the western columns
of a stretch crossing the seam are mostly regions carried over it, which it
cannot touch, so a stretch left thin by the section before could rarely be
mended: nearly every section left wanting was the second or third of a run.
So each section's last fifteen columns are held to one wood and one iron's
worth of their own, leaving the section after something on the far side of
every stretch it is judged by. Holding the last twenty columns to three
quarters of a stretch's worth instead was tried and did no better: it was met
by wood and iron short of the seam, and the last few columns stayed as empty as
before. What is still left wanting after the repair, a few sections in a
hundred, is rerolled rather than chased further: where it was looked at, the
section before ended in water and the section's own first columns were half
rock and river, which no repaint of its own regions reaches. Rerolling for
every wanting window turned out too strict on medium: 30 of its 33 rerolls in
a batch were for windows, and all five sections that used up their attempts
did so on windows at the seam, most of them only a few tiles short. So a
section is let off up to a fifth of its windows wanting, since the few that
slip through tend to be one short stretch just past the seam, but none may
hold less than four fifths of what a window wants, so a deep gap is still
rerolled however short it is.

### What regions are drawn as

Each tier has a table of weights:

| tier | ground | rock | wood | iron | water |
|---|---|---|---|---|---|
| easy | 45 | 15 | 15 | 15 | 10 |
| medium | 20 | 30 | 15 | 15 | 20 |
| hard | 0 | 40 | 17.5 | 17.5 | 25 |

Easy is mostly open ground. Medium has under half of easy's ground, traded for water and rock. Hard has no ground at all,
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

Underneath the bag sit **floors**: at least 3 wood, 3 iron, 2 water and 3 rock
in every section, and on hard 4 wood, 4 iron and 4 rock. Hard's extra wood and
iron are there because the floors fix most of a section's regions and hard's
bag leaves the rest to rock and water: at three each, with the supply counted
properly, a hard batch came out short in thirteen sections of 99 against two
at four, and left three times as many stretches of thirty columns thin, since
fewer resource regions meant more rock in their place. They are met by
holding back the last seeds
drawn for whatever is still owed, never by changing a seed after the fact, and
with the bag in place they rarely have to act. The seeds whose kind is settled
before the draw, the lakes a river ran out against and then the wall, are
drawn ahead of every other seed. Drawn in no particular order, a wall seed
coming up after the floors had been forced put its rock on top of the rock
floor and took a place another floor was still waiting on: one hard batch
averaged 8.6 rock regions of 18, and a quarter of its sections held fewer than
three iron, which is most of what left hard short of iron.

Where wood and iron land is mended by a search rather than by chance.
Fixing each window by swapping a region in at random turned into fixes
undoing each other: windows overlap, so a region taken from outside one
window was usually inside the next, and a few sections repainted dozens of
regions. The search scores the whole section, every window's shortfall, the
tail's and the totals', and only makes the change that lowers that score
most, so it cannot go round in circles and it changes no more than it must;
a stretch without wood that the windows allow stays. Before it, the draw's
wood and iron are nudged so that each half of the section holds one of each.
Spreading them one to a band of columns was tried first and was too strict,
since it did away with the long stretches without wood that make a section
interesting; a half each is loose enough to keep those and still stops a
section piling everything at one end.

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
the rail row and one tile on each row beside it. The first section has the
same yard at its entry, with no station before it, so its first tiles are
never hemmed in either. Every tile of it but the
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

The next prefabs are grass's **pieces**, decided 2026-09-26: a herd of cows,
one on every tile of a patch two wide and one to three tall, and two bandits
on a patch two wide and one tall, each on its own coin in every section and on every
tier. They are ground, marked apart from the section's own ground, and like the
station they cannot be repainted or swapped, nor anything else a prefab is kept
from. They are ground to the track as well: it may run across a herd, so the
pieces add nothing to what a section costs and pinch nothing. What is asked of
them is that the players can get to them, walking anywhere but rock and
bridging water where they must, with the bridges on the way to each paid for
out of the section's supply like the bridges to a region. A piece nobody can
get to is dropped rather than the section rerolled: rerolling for it cost 18
rerolls in 33 hard runs and left 5 sections shipping invalid anyway, since the
rock that walls a piece in stays where it is across attempts. On hard about one
piece in six was walled in, so hard places each piece six times in ten rather
than half the time, to ship about as many; easy and medium stay at half until
their own drop rates are measured.

## Placeholders and open questions

- The easy cost band is a guess until measured
- **Medium's bag is set to cost more than easy.** On a bag of ground 35,
  rock 21, wood and iron 18 and water 9, 99 measured sections came out at a
  median of 1.77 a rail, the middle eighty percent 1.50 to 2.17, which is
  where easy lands too: most of a section's regions are fixed by the floors,
  which are the same on both tiers, the route keeps to the ground that is
  left, and extra rock is gone round rather than paid for. Water is what the
  route has to pay for, so medium's bag now holds a fifth water and a fifth
  ground. Measured again over 198 sections, it came out at a median of 2.09 a
  rail, the middle eighty percent 1.66 to 2.60. Measured on the cheapest way
  across once the second route cuts and the pieces went in, over 99 sections,
  the median is 1.97 and the middle eighty percent 1.60 to 2.49, and its band
  is 1.60 to 2.50
- The test run builds all three of its sections on the tier
  `#gen_test_tier` names while a band is measured; -1 puts back one section
  on each tier
- **The second way across must always exist, and must always go round the
  first route's pinch points.** A section that cannot give one within the
  detour limit, even with the ends opened and rock cut, is rerolled; how often
  that happens, and whether a reroll of the kinds is enough or a section needs
  its wall and rivers laid again, is still to be counted over a batch
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
