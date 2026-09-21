# How DeRailed Generates Terrain

Written 2026-09-19, covering what is built and measured so far. The generator
lives under `datapack/data/derailed/function/dev/gen/` and is still in the dev
folder: it builds into a test area rather than into a running game.

## What it builds

The map is a row of **sections**, each 48 tiles east to west and 16 north to
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
| 17 | the flood's working layer | `validate` | `_flood`, `_trace` |
| 15 | the section as it is meant to be seen | the attempt loop | `_edge_kind`, `validate` |
| 9 | y5 with the river cut into it | the river stamp | nothing - it is the record |
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

`scatter` places 26 seeds as markers, each rolled into a random tile and rejected
if another seed is already within 4 blocks. Seeds average 3.4 tries each, and a
seed that cannot find a clear spot in 30 tries is skipped, so a section
occasionally has 25.

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

Each seed is then numbered 0 to 25 and **grows as its own block** rather than as
its kind. The blocks are the sixteen terracottas and ten of the concretes, with
light blue concrete left out because it is what the river is drawn in on the
visible layer, and white wool making up the count. Two regions that roll the same kind are still different regions, and
the boundary between them is what a river runs along, so it has to stay visible
until the river is cut. The kinds go on at the end, in `paint`.

### 2. Route

`route` decides where the track enters and leaves, and marks the seeds it runs
through as the **chain**.

- The entry row is inherited from the section before
- The exit row is the furthest of three rolls from the entry row, which leans
  exits toward the top and bottom edges rather than the middle
- The chain walks seed to seed in two legs: forward across the section, then
  along the east side to the seed nearest the exit row

The forward leg only ever looks ahead, in a window reaching 12 east and 14 deep,
leaning to the side the exit lies on. Reaching only 12 ahead matters: a longer
step jumps over whatever sits between, and anything jumped over is free to come
out as rock.

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

`rivers` cuts one channel of water along the boundaries between regions, before
any of them knows what kind it will be drawn as. It is a **search, not a walk**:
where it runs out of boundary it goes back to the last choice it passed and takes
a different one.

The search runs on the **lattice of tile corners**, not on the tiles. A corner is
where four tiles meet, and an edge of the lattice is a region boundary when the
**two tiles either side of it differ** - an exact question about neighbours,
where asking about a tile's own surroundings is only a proxy for it. Both tiles
being air instead means that edge leaves the section, which is how a border is
recognised. A tile is laid at each corner the search keeps, and consecutive
corners are neighbours, so the tiles come out joined.

A river sets out from a border. The first section picks **north, south or west**;
any section after it starts where its neighbour's river left off, and failing
that picks north or south - a west start on a section with a neighbour would be a
river appearing from nothing at the boundary.

It is finished when it leaves by a border that is neither the **west** nor the
one it set out from, and when it has run at least `#gen_riv_min` corners - 20. A
river that reaches a border sooner is turned back rather than kept, since the
search has a whole section of boundaries to look through for a longer way out. A
branch that passes `#gen_riv_max` - 120 - is given up on instead. A section 48
wide could be crossed in far fewer, but a river only turns where a boundary does,
so it spends length getting to somewhere it can leave from rather than going
straight there.

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

Three budgets bound it: rolls for starts that turn out to sit on no boundary,
which are cheap, tries for searches actually run, and one count of steps across
the whole section.

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

#### Where it ends

A river leaving by the **east** hands the corner it left by to the next section,
which starts there - the same corner in the world, so the two join squarely
rather than touching at a diagonal.

A section starting that way has nowhere else it may begin, so the search keeps
hold of the longest path it manages and settles for that if nothing reaches a
border. There is no length floor on it: whatever it adds joins a river that
already crosses the section before. Two things follow from settling:

- **A lake is marked.** A river stopping in the middle of dry ground reads as
  unfinished, so one of the regions around the corner it ran out on is drawn
  evenly from the four and its seed is marked to come out water. The seed is
  marked rather than the ground painted, since the kinds are not rolled until
  afterwards and a reroll would draw over it. Only regions the section grew
  itself are eligible: a carried one shares its block with every other carried
  region of that kind, so there is no way to turn one of them alone
- **A second river may be owed.** If the settled river is 6 corners or fewer the
  section searches again from the north or south under the ordinary rules, on top
  of the short one it already laid

The water goes on **the corner the head stood on**, so a river is as wide as the
line the search walked and two corners next to each other are two tiles next to
each other, whichever way the line turned between them. A corner standing outside
the section - the southern and eastern borders, and the one a river crossing
eastward leaves by - lays nothing, which is what keeps a section to its own
ground.

It is cut as a **glaze pointing back the way the head came**, with the branches
the search gave up on in red beside it. That is the search drawn out, and it is
worth having, so y9 keeps it.

What comes up to y15 is the glaze alone, and a fill swaps it there for **light
blue concrete** - a river can then be told from the blue a water region is drawn
in, and the finished section carries none of the search on it. The red is never
lifted at all.

### 6. Kinds

`kinds` gives every seed the kind its region will be drawn as, weighted **ground
20, rock 12, wood 10, iron 10, water 5** out of 57.

Two guarantees are made here rather than checked later:

- **Rock is left out of the draw for chain seeds.** The corridor cannot be
  blocked because rock was never an option along it
- **The resources are topped up.** Drawing per seed makes resources lumpy - with
  two dozen seeds a section can easily roll a single patch of wood - so ground
  seeds picked at random are converted until there are at least 4 rock, 4 wood,
  4 iron and 2 water. Rock goes first, since it is the one that may not land on
  a chain seed and so has the fewest seeds to choose from

The top-up removed nine rerolls in every eighty sections.

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

`validate` floods from the entry tile across everything that is not rock and not
outside the section, and checks it reaches the exit tile. Water is crossable,
since water can be bridged.

The flood marks each tile on a layer two above the section, in a colour recording
**which way it arrived**. That turns the layer into a set of arrows pointing
home, so the route can be walked back from the exit afterwards.

A ring of grey glass is laid around the section first, filling only air, so the
flood stays inside its own section without painting over its neighbour's route.

If the section fails, every seed's kind is rolled again and it regrows, keeping
the seeds and the chain. Up to 5 attempts.

## What it costs

Measured 2026-09-21 with `dev/gen/profile` run from a command block every tick
for the profiler's ten seconds - about a hundred whole three-section maps, with
the stands and the report switched off so that only the generating is timed.
The sections were 35 by 20 then; at 48 by 16 a section has a tenth more tiles
and has not been profiled since, so read these as a tenth under.

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

A section is 768 tile claims, about 33 waves, and a flood visiting around 290
tiles. Three sections come to about 80ms, one and a half ticks as a burst and
nothing at all spread across three or four.

## Looking at it

- `dev/gen/test` builds three chained sections at x 1000 and prints a report. It
  positions itself, so it is safe to call from anywhere
- `dev/gen/run_grow` is the benchmark: four repetitions of 21 sections, profiled
  with F3+L, cleaning up on the tick after
- `dev/gen/clear` empties the whole stack. `init` and each benchmark pass call it,
  since a layer left standing from an earlier run reads as terrain beyond a
  border and no river can then find its way out
- `dev/bench/stop` clears the area and lets the game tick run again

The finished section is at **y=15**. Above it, **y=16** holds a red block over
every chain seed and a gold one over the seed the track must end on, and **y=17**
holds the flood: pale blue, cyan, purple and white glass where it went, red along
the route it found. Red only means it walked straight to the exit without a wrong
turn.

Below it are the working layers, and they are worth reading when a river needs
explaining: **y=9** has the line the search walked with everything it gave up on
in red, **y=5** the kinds without the river, and **y=0** the regions as they
grew. `utils/worldread.py` takes `--y` and reads any of them out of the save.

`#gen_riv_hold` stops each section the moment its river is cut, keeping the
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
- **Nothing stops a section being trivially easy.** About one in fifty has no
  rock at all. Guarding against that properly means scoring the cheapest way
  across - ground 1, resource 2, water 4 - and requiring a minimum, which needs
  a least-cost search rather than the depth-first flood
- **Seeds sit at tile corners**, since the scatter rolls whole tiles. Sub-tile
  seed positions would take blob accuracy from about 92% to about 98% against
  true Voronoi
- **The traced route is not the shortest one.** Depth-first search finds a way
  through, not the best way, so the red line wanders and its length overstates a
  real track. Nothing reads it - it is there to be looked at
