# How DeRailed Generates Terrain

Written 2026-09-19, covering what is built and measured so far. The generator
lives under `datapack/data/derailed/function/dev/gen/` and is still in the dev
folder: it builds into a test area rather than into a running game.

## What it builds

The map is a row of **sections**, each 32 tiles east to west and 16 north to
south, laid end to end going east. Every section is generated whole and joins
the one before it, so the map is continuous rather than a row of tiles.

Terrain comes in **blobs**, not per-tile noise. Each section scatters a couple of
dozen seeds and grows a region from each, and every region is one kind
throughout. Kinds are ground, wood, iron, water and rock, stood in for now by
coloured concrete:

| kind | placeholder | passable |
|---|---|---|
| ground | lime concrete | yes |
| wood | brown concrete | yes |
| iron | light grey concrete | yes |
| water | blue concrete | yes, by bridging |
| rock | grey concrete | no |

## The layers

A section is built on four layers, one above the other, all reckoned from the
corner it stands at. Nothing is drawn where it is read from, which is what keeps
every question about a section answerable for as long as the section takes:

| y | what | written by | read by |
|---|---|---|---|
| 17 | the flood's working layer | `validate` | `_cost_spread`, `_trace` |
| 15 | the section as it is meant to be seen | the attempt loop | `_edge_kind`, `validate` |
| 9 | y5 with the rivers cut into it | the river stamp | the second river, to find the first |
| 5 | **what the river reads, then the kinds** | `build`, then `paint` | `_river_look_*`, lifted to y15 |
| 0 | **the regions as they grew** | growth only | `_river_lake`, `_read_id` |

y0 holds the block each region grew as and is never drawn over, so whatever asks
which region a tile belongs to gets a straight answer however far along the
section is.

y5 does two jobs, one after the other, and that is the thing worth understanding.
`build` lays it out as a copy of y0 before the river is cut, so while the search
runs it holds this section's regions as they grew - and every section before it
has long since had its kinds painted there. A river looking **west across a seam
therefore compares against the section before as it was drawn**, not as it grew,
which is the same thing a region carried over that seam is standing in and so
matches. Looking east or inside its own section it compares region blocks against
region blocks. Neither side ever reads as a boundary that is not one.

Once the river is cut nothing reads y5 as regions again, so painting is free to
swap them for kinds in place.

y15 is y5 with the river lifted onto it by a filtered clone, so only the blocks
the river was cut in come up and the branches the search gave up on stay down on
y9 where they can be looked at without standing in the finished section.

## The pipeline

`build` runs these in order, positioned at the section's corner. `next_section`
works out where that corner is and hands the previous section's exit row on.

### 1. Scatter

`scatter` places 18 seeds as markers, each rolled into a random tile and rejected
if another seed is already within 4 blocks. Seeds average 3.4 tries each, and a
seed that cannot find a clear spot in 30 tries is skipped, so a section
occasionally has 17.

The spacing is what keeps regions an even size. Nothing relaxes them afterwards,
so it is also **the knob for how blotchy a section looks**: seeds free to cluster
grow regions that vary in size and shape, seeds held apart grow regions of a
size. `#gen_spacing` holds it.

The section before **keeps its seeds through the scatter** so that the spacing
carries over the boundary. Without them a seed can land a tile inside this
section while one of theirs sits a tile the other side - closer than two seeds
are allowed to be anywhere else on the map - and the region it grows takes the
whole edge off whatever the seam was carrying over.

The **westmost column is left clear** of seeds as well, since that is the one the
seam plants into: a seed there keeps its own tile, and the row it sits on carries
nothing over.

Keeping more than one column clear does not work, however tempting it looks.
Nothing but a carried region can reach a reserved strip, so the carried regions
win all of it, every time, and **the edge of the reservation comes out as a
straight line down the whole section**. Three columns were tried and that is
exactly what happened.

Every seed also gets an armour stand over it, which is only there to be looked
at. `dev/gen/init` clears them along with everything else a run leaves behind.

Each seed is then numbered from 0 and **grows as its own block** rather than as
its kind. The palette has room for 26: the sixteen terracottas and ten of the
concretes, with light blue concrete left out because it is what the river is
drawn in on the visible layer, and white wool making up the count. Two regions that roll the same kind are still different regions, and
the boundary between them is what a river runs along, so it has to stay visible
until the river is cut. The kinds go on at the end, in `paint`.

### 2. Route

`route` decides where the track leaves. The entry row is inherited from the
section before, and the exit row is the furthest of three rolls from it, which
leans exits toward the top and bottom edges rather than the middle. Nothing is
reserved for the track: where it can go is settled by the terrain and by
`validate`, which cuts through rock where it must.

### The wall

On hard, once the regions have grown, `wall` runs a band of rock from the
north border to the south. It starts at the seed nearest a random point on the
north border and steps south seed to seed, taking the nearest seed in a window
eight rows deep and six columns either side, until it stands in the last four
rows, has taken eight steps, or finds no seed in the window, and from there it
runs straight south to the border. Between the border point and the first seed,
and between each seed and the next, it walks a line of tiles a step at a time,
always the way that has further to go, and puts every region under that line
on the band. So the band is joined from end to end and reaches both borders,
and it meanders wherever the seeds lead it. Its seeds come out rock whatever
the draw says, and pay the rock floor and charge the bag like any draw. The
cheapest way across has to cut through the band somewhere, and the cut is a
passage one tile wide with the band's rock either side of it, which is what
gives a hard section its pinch; the floor check stays behind that for the rare
cut through a thin diagonal of rock with nothing beside it.

A region carried over the seam keeps its kind and has no seed to put on the
band, so a line through one leaves a hole. The band is laid again from another
column, up to four times, and a hole left after that is counted in the report.

### 3. Grow

`grow` fills the section with black concrete as unclaimed ground, then every seed
claims its own tile and grows outward in waves.

- A straight step lands **5 waves** later, a diagonal one **7**. That ratio
  approximates the real 1.41 closely enough that blobs come out round rather
  than diamond shaped
- Waves are carried by **eight rotating tags**. Since the delays are only 5 and
  7, eight tags cycle without a delay ever landing back on the wave being woken,
  so no marker needs a wave score and nothing has to be aged
- A tile is claimed when it is **scheduled**, not when it wakes, so there is one
  marker per tile rather than one per attempt. That costs a little blob accuracy
  and saves about three quarters of the markers
- **Every straight step in a wave is taken before any diagonal one**, which is
  why a wave is two passes over its markers rather than one. Claiming on
  scheduling means whichever marker the wave reaches first takes the tile, so
  without the split a marker's diagonal step reaches a tile ahead of the
  neighbouring marker's straight step into the same tile - costing 7 where the
  other would have cost 5. The seam is where it showed: every carried region
  starts at wave 0 in one column, so the region planted in the earlier rows took
  contested tiles from the one below it, and each boundary between two carried
  regions was dragged a row south for every column it crossed instead of running
  flat. The first pass hands the region to the marker so the second does not read
  the tile again
- **The region goes into the block and onto the marker both.** The block is the
  record everything after growth reads. The marker is handed the region as it is
  summoned - `execute summon ... run` into one of eight tiny `_born_N` functions,
  one per wave tag - so an activating marker reads a score rather than a block.
  Reading the block back was a ladder of 29 tests, thirteen deep on average, and
  cost more than the summon itself
- **Writing the block is a four way ladder**, not one of 31: two range tests pick
  a ladder of seven or eight. A region is as likely to be any number as any
  other, so one ladder would average sixteen tests where this averages six
- **The wave loop counts rather than looks.** How many tiles are due and how
  many are waiting on the seam are kept as scores, so the loop test is two
  score reads rather than two scans of every entity - each of which cost as
  much as a hundred block tests
- **The sweeps stay unbounded.** Boxing them to the section with `dx/dy/dz`
  reads as the obvious saving and was measured slower, +0.15ms a section: with a
  few hundred entities loaded, a box test on each costs more than a flat pass
  with a tag check. A box also treats a marker on one of its faces as outside,
  and every marker here stands exactly on y 0

The black fill doubles as the section boundary: growth only takes tiles that are
still black, so it stops at the edge without any bounds checking.

### 4. Seam

Before the waves run, `seam` carries the regions on the far side of the western
boundary into this section, so a blob keeps **both its identity and its shape**
across the seam.

As a section grows, every tile taken in its last column leaves a **note** - a
marker holding which region took it and on which wave. Once the section settles,
the note also takes down the kind that region ended up drawn as, which has to
wait until then because a reroll would have changed it underneath.

The section after reads those notes. A carried region **grows straight into the
block its kind is drawn in**, taking ids 26 to 30 - the tail of the same ladder
the section's own regions use, pointing at the kinds palette rather than at
blocks of their own. It has no seed and nothing to roll: its kind was settled the
moment it came over.

That is also what lets the river read the seam. The section before has y5 drawn
in kinds by then, so a carried region and the region it came from are the same
block on both sides of the line and do not answer as a boundary. Growing it as a
block of its own would put a false boundary down the whole height of every seam.

The cost is that two carried regions that came over as the same kind merge into
one, and the boundary between them is gone. That is accepted. It also tells
carried ground apart from the section's own ground on sight, which is what
`#riv_bleed` uses.

A carried region is a **line, not a point**, and that shows. It is planted along
the whole of its stretch of column 0, so its distance to a tile in column c is
the same 5c whatever the row - and the contours of a line are parallel straight
lines, so its boundary against anything else tends to land at a constant column
rather than curving the way a boundary between two seeds does. The original has
no such trouble: it pins each carried region to a **point one tile west of the
section**, and distance from a point varies by row. Ours would want the same to
draw the seam properly.

Every carried region **sets off at once**, however far back its seed really was.
How far back is known - the note records the wave its tile was taken on - and
using it is the obvious thing to do, but it is wrong. This section's own seeds
all start from nothing, so a region measured from a seed a section away loses
every contested tile to them, the edge goes to whatever this section rolled, and
the boundary comes out drawn straight down the seam. Setting them all off
together is what makes them competitive, and amounts to treating each one as
though its seed sat a single tile past the western border.

### 5. Rivers

`rivers` cuts one or two channels of water along the boundaries between regions,
before any of them knows what kind it will be drawn as. Each is a **search, not
a walk**:
where it runs out of boundary it goes back to the last choice it passed and takes
a different one.

The search runs on the **lattice of tile corners**, not on the tiles. A corner is
where four tiles meet, and an edge of the lattice is a region boundary when the
**two tiles either side of it differ** - an exact question about neighbours,
where asking about a tile's own surroundings is only a proxy for it. Both tiles
being air instead means that edge leaves the section, which is how a border is
recognised. A tile is laid at each corner the search keeps, and consecutive
corners are neighbours, so the tiles come out joined.

Rivers run **between north and south**. A border is rolled once for the
section, and each river sets out from it at a random column and is finished only
when it leaves by the border across from it. The east and west borders are
walls, nothing crosses a seam, and a section's rivers owe nothing to its
neighbours'. Every section gets a first river; it gets a second only when the
first came up short.

The first river has to run at least `#gen_riv_min` corners - 20. A river that
reaches the far border sooner is turned back rather than kept, since the search
has a whole section of boundaries to look through for a longer way out. A branch
that passes `#gen_riv_max` - 80 - is given up on instead. A section 32 wide
could be crossed in far fewer, but a river only turns where a boundary does, so
it spends length getting to somewhere it can leave from rather than going
straight there. That floor is the search's own count of corners, taken before
the shortcut, so a river can come out under it once its loops are cut; the
pair's reckoning below uses the tiles actually laid, since the search count
was seen running to three times them.

A step **west out of column 0** is shut off: the section before's terrain lies
the other side of that line rather than air, so such a step reads as an ordinary
boundary and would carry the river back into a section already built. Running
north or south *along* that line is allowed, since a region boundary may well run
there, and the water lands in column 0 rather than across it.

Bleed off the section before reads as one region however many it was, so there is
nothing inside it to follow. Where **every tile meeting a corner is a kind block**
the search stops weighing turns and carries straight on until it reaches ground
the section grew for itself.

At each corner all three ways on are weighed - straight, and the two turns.
Carrying straight on counts **three** against a turn's **one**, and the step is
rolled from whichever are open; 60 divides by every total the three weights can
come to, so one roll of 0 to 59 is even however many there are. A way whose
corner already holds a tile is not open, which is what keeps a river from
crossing itself, and it is also what records which ways a choice has already
tried: a tile stands on every one of them, written off or not.

**Markers hold the search, not blocks.** A *head* walks the lattice; a *tile* is
laid at each corner it keeps, carrying the depth of choices it was laid at; a
*note* is left wherever there was more than one way on, carrying that depth and
the way the head arrived; and a *start* is left behind at each corner set out
from, so none is tried twice.

Going back is what the depth is for. Everything laid since the last choice shares
one depth, so it is written off in a single sweep rather than a walk back tile by
tile - and it is written off rather than removed, since a tile standing on a
corner is what says that way is spent. The head then stands on the note at that
depth and takes another way; if nothing is left there the note goes, the depth
drops by one, and it goes back further. Reaching depth 0 with nothing left means
no river can be had from that start, which is left behind as one not to try again
while the search begins somewhere else.

Three budgets bound each river: rolls for starts that turn out to sit on no
boundary, which are cheap, **five** starts that a search is actually run from,
and one count of steps shared by all of them.

#### The shortcut

A search that doubles back leaves a line that loops around on itself, and laid as
it stands that comes out wider than one tile. So once a river is settled the line
is **walked again from the corner it set out from**, and at each corner the walk
goes to whichever of the four next to it the search reached latest. Every tile
carries the step it was laid at, which climbs along whatever line is standing -
backtracking only ever takes the tail off and puts a later one on - so of two
corners next to each other the higher is always the further along, and stepping
straight to it leaves the loop between them behind.

Nothing else is asked of that step. The two corners are one apart and both stand
on the line, so going between them is the river taking the near way round. Only
the corners the walk passes through are kept.

#### The second river

A first river that laid `#gen_riv_pair` tiles or more - 40 - is the section's
whole river. A shorter one gets a second, which sets out from the same border as the
first, at a column at least `#gen_riv_apart` - 6 - away from where the first
did, so that it does not run into it at once. It may finish by the far border like the first, or by
**running into the first**: a way on whose corner already holds water is an exit
like any other, and the river stops on the corner beside it. The first river's
water is on y9 by then, which is the one thing about the first that the second
can see. Water in the section before is not looked at, since that is another
section's river and a river joining it would be a river leaving by the west.

It is held to whatever brings the pair up to `#gen_riv_pair` - 40 - between
them, and never less than `#gen_riv_2nd` - 10 - so that a long first river does
not leave it a puddle.

#### Falling back

A river none of whose five starts reached an exit lays the **longest line any of
them found** instead. The line is kept from one start to the next by letting go
of its place on the lattice, so the next start is free to run over its corners.

A river that stops in the middle of dry ground reads as unfinished, so one of
the regions around the corner it ran out on is drawn evenly from the four and
its seed is marked to come out water. The seed is marked rather than the ground
painted, since the kinds are not rolled until afterwards and a reroll would draw
over it. Only regions the section grew itself are eligible: a carried one shares
its block with every other carried region of that kind, so there is no way to
turn one of them alone.

When the first river falls back short, the second is asked for the whole of the
rest and will usually fall back too, so that section ends up with two short
rivers and two lakes. The report counts how often.

The water goes on **the corner the head stood on**, so a river is as wide as the
line the search walked and two corners next to each other are two tiles next to
each other, whichever way the line turned between them. A corner standing on the
southern border is outside the section and lays nothing, which is what keeps a
section to its own ground.

It is cut as a **glaze pointing back the way the head came**, with the branches
the search gave up on in red beside it. That is the search drawn out, and it is
worth having, so y9 keeps it.

What comes up to y15 is the glaze alone, and a fill swaps it there for **light
blue concrete** - a river can then be told from the blue a water region is drawn
in, and the finished section carries none of the search on it. The red is never
lifted at all.

### 6. Kinds

`kinds` gives every seed the kind its region will be drawn as. There are three
**tiers**, picked by `#gen_difficulty` - 0 easy, 1 medium, 2 hard - and each
has a table of weights:

| tier | ground | rock | wood | iron | water |
|---|---|---|---|---|---|
| easy | 45 | 15 | 15 | 15 | 10 |
| medium | 35 | 21 | 18 | 18 | 9 |
| hard | 0 | 43 | 14 | 14 | 29 |

Hard has no ground at all, so every tile of a route there costs at least 2, and
it has the wall on top.

A table is not rolled from directly. It fills a **bag** - the five weights in
hundredths of a percent, ten thousand in all - and every draw then takes
`#gen_bag_take` percent of one seed's share off the kind drawn, half a share,
and hands the same amount out to the other kinds **in the tier's own ratios**.
A kind is charged the whole take whatever it holds, so it can fall below
nothing, and while it is there it is out of the roll: every pick of another
kind pays it back its part of what was taken, so a rare kind drawn too often
sits out for most of the bag while a common one is back in a few picks. The
roll runs over whatever the bag holds above nothing. Simulated over 200,000
hard sections of 18 seeds, seven or more iron regions came up in one section in
67 and eight or more in one in 1000, against one in 22 and one in 91 for
independent rolls, while six still came up one section in eleven. The bag is
filled once a section and first charged for what the seam carried in: each
kind's bled tiles, counted as the regions grew, over the average region of 512
tiles by the seed count, taken off that kind as whole shares. A seed the river marked for a lake takes water
out of the bag like any other draw.

Every section is also held to a floor of **3 wood, 3 iron and 2 water** regions,
and **3 rock on easy and medium or 4 on hard**, and the floors are met without
converting anything. A running count keeps what is still owed to the floors
against how many seeds are left. While there are more seeds than owed, each
draws from the bag; the moment the two are equal the remaining seeds take what
is owed instead, wood first, then iron, water and rock. That keeps the table's
ratios for as long as they can be kept and lands the forced kinds on the last
few seeds, which are random ones anyway.

A seed on the wall is rock and a seed the river marked for a lake is water,
whatever the bag says, and each pays its floor like any other draw.

### 7. Paint

`paint` walks the seeds and runs one `fill ... replace` per region on **y5**,
swapping that region's own block for the block its kind is drawn in. The regions
carried over the seam came over as kind blocks already, so no fill matches them.

An attempt is the whole of a reroll, and it begins by laying y5 out again from
y0 - painting works by swapping a region's own block for its kind, so it needs
the regions back to have something to swap. Then y5 goes down to y15 whole and
the river is lifted onto it from y9. Nothing of the last attempt has to be undone
and no copy is kept aside: the layers below are the copy.

The river is cut once, before any of this, and never again. It reads y5, which
owes nothing to the kinds, so a reroll cannot change what the search would have
found.

### 8. Validate

`validate` floods from the entry tile across everything inside the section,
**cheapest tiles first**, and stops the moment it reaches the exit tile. Each
tile costs something to step onto - ground 1, wood or iron 2, water 4 since
water can be bridged, rock 1000 - and a tile is taken on the wave its cost
falls due, so the first wave to take a tile is the cheapest way there and the
wave the exit is taken on is **the cost of the cheapest route across**. The
waves are the trick growth uses with a tile's cost as its delay: eight rotating
tags, one marker per tile taken, and no queue to keep sorted. The cost sits on
the tile being stepped onto rather than on the step, which is what makes taking
a tile on first arrival exact.

Rock's thousand is done in **levels** rather than waves. A rock tile the flood
comes up against is claimed with its arrow and parked with the wave it was
reached on. When the level has run out without reaching the exit, the next
level starts the wave count over and wakes each parked tile on the wave it was
parked with, so a tile taken on level k at wave w costs k thousand plus w, which
is exactly the number the thousand stands for. Rock is therefore only ever
crossed where no way round it exists, and there at its thinnest.

A route that went through rock is then **cut**. The trace gathers the rock on
it into runs, each numbered from its exit end and each knowing what stands on
the route at its two ends, and once the whole route is known every run is
filled in by its ends. **Water at both ends, river or lake either, runs
through the whole cut as river.** A river at one end gives way to the land at
the other, ground, wood or iron, which then fills the whole cut. Any other run
is filled from both ends at once - first tile, then last, then second and last
but one - each tile becoming whatever terrain other than rock or river is
nearest, looking next door first, then at the corners, then two away, so that
the cut takes the terrain it opens onto at each end and the two meet in the
middle; a tile with nothing but rock and river round it becomes ground. All of
it goes on the visible layer and the kinds layer both. A run still open at the entry tile
ends against the section before, whose tile is read as its entry end. The flood
then runs once more over what it cut, since that rock-free route is the one
the players will have, and that is the route judged.

Rock cut to open a pinch up is filled the second way only, tile by tile from
the nearest terrain, never river.

The same walk measures how much the route **pinches the train**. The train is
a box two long and one wide, pointing the way the track runs, and the players
cannot pass through it, so what matters is whether rock closes both of its
sides at once. Sliding the box along the route a half step at a time comes to
a window of three route cells: each side is closed when rock stands beside any
of the three, on that side of the box, and the window is pinched when both are.
Only rock counts; everything else the players can clear. The section's edges
count as rock too: the north and south edges, since nobody gets round the
train past the edge of the map, and the east edge, since what stands past it
is not built yet. The west edge never comes up, since the route never runs
along the western column. The box's left is its own, so it turns with the
track at a corner, which needs no case of its own. A run of consecutive
pinched windows costs its length cubed, so one long pinch weighs far more than
the same length broken up, and two short runs a cell apart score the same as
one long one, which is what a box two long makes true. The section's score is
the sum over its runs.

The tier sets a ceiling on that score and hard sets a floor as well. Over the
ceiling the section is not thrown away: the longest run is **opened up**, the
rock along one side of it cut back from the exit end just far enough that what
is left of the run would pass, taking whichever side has less rock along those
cells and never a side that faces out of the section, since the edge cannot be
cut; then the route is found again, and the score taken afresh, for up to four
rounds. Under hard's floor is a reroll like a cheap
route. The bands: easy allows no pinch at all; medium allows 54, two single
rows of rock either side far enough apart not to touch, at 27 each; hard wants
at least 27, one such row, and allows up to 343, a corridor five rows long,
which is seven windows. Two short corridors a row apart count as the one long
one, so hard's ceiling is as much about spacing as about length.

Before any of that, the **exit tile is kept off rock**: if the row picked lands
on rock and any other row of the east edge is clear, the exit moves there,
keeping the lean away from the entry row. The first section's entry is kept off
rock the same way. Without this a section whose exit region grew as rock would
have to dig into it at the very edge, and the section after would have to dig
its way out, where any other row would have done.

The flood marks each tile on a layer two above the section, in a colour recording
**which way it arrived**. That turns the layer into a set of arrows pointing
home, so the route can be walked back from the exit afterwards. Once the route
is drawn the arrows are cleared, and the route is all that stays on the layer.

A ring of grey glass is laid around the section first, filling only air, so the
flood stays inside its own section without painting over its neighbour's route.
The western column gets the same glass, all but the entry tile, so the route
never runs along the seam, where the station will stand.

The route is then judged by **what it costs a rail**, not by its total. The time
the players get is the rails they lay, so a longer way across is not a harder
one on its own: a zig-zag buys the time to match its cost. What a longer way is
is more rails out of the same supply and more time at the same pace, so the
cost a rail is raised by `#gen_rail_pen` percent - 1 - for every rail past the
32 of a straight crossing. The figure is kept in hundredths of a point a rail
so that it stays a whole number.

A section is usable when the exit was reached and that figure lies between the
tier's floor and ceiling, set in `build`: 1.55 to 2.20 on easy, 1.85 to 2.50 on
medium and 2.65 to 3.30 on hard. The hard pair comes from ten measured sections;
easy and medium are placeholders until a batch has printed theirs. Wood and iron
need no check here, since the floors in `kinds` guarantee them. If the section
fails, every seed's kind is rolled again and it is painted again, keeping the
regions and the seeds. Up to 5 attempts.

The figure is taken on the cheapest route by total cost, which is the natural
line across. A longer detour can average less a rail, so this overstates a
little what a player padding their route with ground could get. The true
lowest-average path is out of reach in commands, and without a rail budget it is
not even well defined, since a loop through ground drags any average toward 1.

## What it costs

Measured 2026-09-21 with `dev/gen/profile` run from a command block every tick
for the profiler's ten seconds - about a hundred whole three-section maps, with
the stands and the report switched off so that only the generating is timed.
The sections were 35 by 20 then, with one river each and a depth-first flood.
At 32 by 16 with two rivers and the least-cost flood a section has fewer tiles
but more searching, and has not been profiled since.

| stage | per section | share of generation |
|---|---|---|
| grow | 9.1ms | 36% |
| unattributed | 7.4ms | 30% |
| layer clones and the river lift | 3.2ms | 13% |
| rivers, the whole search | 2.4ms | 9% |
| validate, seam, scatter, route, kinds, paint | 1.5ms | 6% |
| misc: init, wipes of markers, the seed rolls | 1.4ms | 6% |
| **a section** | **25ms** | |

The test harness adds a `clear` of the whole area on top, 5.5ms a section, which
shipping generation will never do.

**Unattributed** is the profiler's own bucket for time inside the function that
belongs to no one command. It moved with the command count when two thousand
commands a section were taken out of growth, so it reads as per-command overhead,
and anything that removes commands takes it down as well.

**Growth's 9.1ms is near the floor of its algorithm.** Two thirds of it is one
marker per tile doing what it must: eight block tests to find its neighbours
(2.4ms), a `kill` (1.4ms) and a summon (1.4ms). The id ladders and the loop's
entity scans, which used to make up as much again, are gone - see the Grow
notes above. What is left to take is small: the black fill (0.75ms) could become
a barrier ring at a third of the cost, and the per-wave overhead (1ms) would
halve with step costs of 2 and 3 in place of 5 and 7, at the price of blobs
drawn to a ratio of 1.5 rather than 1.4.

**Lighting** is 2.3ms of the 25 and sits entirely under the bulk clones and
fills; the per-tile `setblock`s cost none, since a block replaced by one of the
same opacity never reaches the light engine. Transparent blocks on the working
layers would take most of it out, but the visible layer has to end up opaque
whichever way it is reached, and the palette needs 26 stateless blocks that
glass alone cannot supply.

### Reading a profile

The profiler's server dump lists every command run under the function that was
called, flat: a stage's own function does not appear as a node of its own, and
nothing nests beyond the command. So the shares above come from matching each
command string back to the file it lives in and summing by stage, which is what
the script that produced them does. It bottoms out inside the recursive parts
either way, so the wave loop and the river search are attributed as wholes.

A section is 512 tile claims, about 30 waves, and a flood visiting a couple of
hundred tiles. Three sections at the old size came to about 75ms, one and a
half ticks as a burst and nothing at all spread across three or four.

## Looking at it

- `dev/gen/test` builds three joined sections at x 1000, one on each tier -
  easy, then medium, then hard - saying what each cost against its bounds, and
  prints a report. It positions itself, so it is safe to call from anywhere, and
  it puts the tier back to what it was
- `#gen_difficulty` is the tier every section from then on is built to: 0 easy,
  1 medium, 2 hard. `run_grow` builds all of its sections on it
- `dev/gen/run_grow` is the benchmark: four repetitions of 21 sections, profiled
  with F3+L, cleaning up on the tick after
- `dev/gen/clear` empties the whole stack. `init` and each benchmark pass call it,
  since a layer left standing from an earlier run reads as terrain beyond a
  border and no river can then find its way out
- `dev/bench/stop` clears the area and lets the game tick run again

The finished section is at **y=15**. Above it, **y=16** holds orange glass over
every tile the route cut through rock and yellow over every tile cut to open a
pinch, and **y=17** holds the cheapest route across in red glass, inside a grey
ring.

Below it are the working layers, and they are worth reading when a river needs
explaining: **y=9** has the line the search walked with everything it gave up on
in red, **y=5** the kinds without the river, and **y=0** the regions as they
grew. `utils/worldread.py` takes `--y` and reads any of them out of the save.

`#gen_riv_hold` stops each section the moment its first river is cut, keeping the
corner markers standing and the kinds never drawn over the regions on y5. Where the
water lands is not where the walk stood, so reading a river back off the map is
guesswork; this leaves the line itself there to be read.

## The nearest seed way, tried and put aside

Regions can be drawn without growing them at all: walk every tile, ask `@n` which
seed is nearest, and take that seed's block. It was built, measured against the
waves and taken out again. Written down here because the numbers were good and
the reason for dropping it was not a number.

It was **faster, by a third**. Over 21 sections four times, rivers off:

| | per section |
|---|---|
| waves | 22.9ms, and 20.5ms on a repeat |
| nearest seed | **14.5ms** |

Two runs of the same code came out 11% apart, so that gap is well clear of the
noise - every one of its four ticks beat every one of theirs.

The selector was the cheap part, which is the opposite of what was expected:
**0.2ms a section for all 700 lookups**, bounded to `distance=..15` so it works
from a box of chunks rather than walking every entity in the dimension. Six times
the seeds, for the densest biome, still would not have closed a 6ms lead.

What it gave up was the **look**. It draws exact Voronoi - true Euclidean
nearest, so cells come out convex with straight edges, and rounder and tidier
than the waves draw them. The waves are ragged instead, and the raggedness is
mostly **error**: a tile goes to whichever region schedules it first rather than
whichever is nearest, which puts about 4% of tiles in the wrong region, scattered
along the boundaries. That error is what reads as organic, and the tidy version
read as worse even though it is the more accurate one.

Loosening `#gen_spacing` from 4 to 3 was tried against it, on the grounds that
evenly spread seeds are what make even regions. It did not rescue the look.

Two things it never got:

- **no seam.** A carried region would have to become a seed, and a seed carried
  over holds an id of 0 to 25 from its own section, which collides with this
  section's. They would need renumbering into the 26 to 30 a carried region uses
- **no `_edge_note`.** Without the black fill there is no air to the east to test
  for, so the last column has to be known from the tile count instead

One thing it turned up that still stands: the waves find the last column by
testing for air to the east, so a section built where an older one still stands -
which is what the benchmark does from its second pass on - leaves **no edge notes
at all**, and its seam fails silently. Play builds into fresh ground and
`dev/gen/test` clears first, so it only bites the benchmark.

## Known gaps

- **No station or other set pieces**
- **Placeholder blocks**, not DeRailed's own
- **No queue.** Sections are built in one go rather than spread over ticks
- **The easy and medium bounds are placeholders.** Only hard's cost a rail has
  been measured; the other two want a batch run before their floors mean
  anything
- **Seeds sit at tile corners**, since the scatter rolls whole tiles. Sub-tile
  seed positions would take blob accuracy from about 92% to about 98% against
  true Voronoi
