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
| 18 | the first route and the band and zone round it, while the second is found | `second` | `_sec_visit`, `_pinch_cut` |
| 17 | the flood's working layer, then both routes | `validate`, `second` | `_cost_spread`, `_trace` |
| 15 | the section as it is meant to be seen | the attempt loop | `_edge_kind`, `validate` |
| 14 | how far water is, while the water check runs | `_water_area` | `_water_check` |
| 9 | y5 with the rivers cut into it | the river stamp | the second river, to find the first; `strays`, for where the river runs |
| 5 | **what the river reads, then the kinds** | `build`, `strays`, then `paint` | `_river_look_*`, `strays`, lifted to y15 |
| 0 | **the regions as they grew** | growth, then `strays` | `_river_lake`, `_read_id` |

y0 holds the block each region grew as, and only `strays` ever changes it, when
it hands a tile to another region after the rivers, so whatever asks which
region a tile belongs to gets a straight answer however far along the section
is.

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

### The station, before anything

`route` picks the exit row first, since the station stands on it, clamped to
rows 1 to 13 so the piece fits, and `_station_stamp` lays the piece on y0 in
blocks of its own before a seed is placed: **bedrock** for its ground, the
rail row from column 28 to the edge, the tile above its buffer stop, the two
rows below it from column 29 and the yard in the section after (columns 0 and
1 on the entry row, column 0 on the rows either side, which the first section
has at its own entry too), all of it open to the
players and the track alike, and **obsidian** for the building, the two tiles
above its first two rails, which nothing crosses. Those two
blocks are what every later step reads: seeds are never placed on them,
growth never claims them, no region id answers for them so no region owns
them, the wall counts a line through them as a hole, the stray sweep and the
repaints skip them, and no cut and no relief ever opens them. `grow` lays the
piece again over its black fill, and every attempt draws it on y15 after
painting, ground everywhere but the building and rock there, with powered
rails, a buffer stop and bricks on y16 above. `#gen_station` in `load` turns
the whole of it off.

Both routes run from the first tile the track is laid on, column 0 of the
entry row, to the last, which is either of the two tiles beside the station's
first rail, the yard tile west of it or the ground south of it, whichever the
flood reaches first: both are marked as the goal, and the trace starts from
the one the flood left an arrow on. The station's three rails are laid
already, its buffer stop becoming the third when the section after is built,
so they are neither rails to lay nor route to measure: they count as seen
already on the flood's layer, so neither route ever runs over them, and the
straight crossing a route is judged against is 29 rails. Leaving the buffer
stop south
into the ground below it, rather than east into the yard, lays the same number
of rails to reach the same yard tile, so the flood from column 0 prices that
way too. The first route's flood never steps onto the building, while the
second route and the supply flood walk everything but it, since the players
can. The station's four tiles on the eastern edge leave notes reading ground,
so the section after carries ground in from them and grows it from there on
whatever rows its yard does not already cover.

### The pieces, straight after

`_pieces` then lays the section's **pieces** on y0 the same way, each on a
coin of its own and on every tier: a herd of cows, two columns wide and one to
three rows tall with a cow on every tile, in **hay**, and a pair of bandits,
two wide and one tall with a bandit on each tile, in **red nether bricks**. Each goes at a spot taken at
random from column 2 to column 27, so clear of the yard and the station, where
none of its tiles is a prefab's already, tried up to `#gen_piece_tries` times,
30, before the section goes without it. Both blocks are in `#derailed:prefab`,
so a piece is kept out of everything the station is kept out of: no seed, no
growth, no region, no river, no stray, no cut, no repaint and no swap, and a
wall through it has a hole. Its rectangle is kept in the storage list
`pieces`, which `grow` lays again over its black fill; its northwestern tile
has a `dr_piece` marker tagged `dr_cows` or `dr_bandits`, with how many
creatures it holds in `dr_size`; and white glass for cows or red for bandits
goes over it on y16. Every attempt draws it on y15 as plain ground, so the
routes, the pinch measure, the supply and the water check all take it for
ground, and the track may run across it.

A piece the players cannot get to is no use, so the supply check's flood,
which sets out from the first route and walks everything but rock, is asked
whether it reached each one. `_piece_reach` walks the flood back from each
piece it reached before any region is taken, charging the bridges on the way
to it like the bridges to a region and building them for whatever comes after,
and **drops** each piece it did not reach, tagging its marker `dr_dropped` for
that attempt; a section that ships with one dropped has black glass on the
dropped piece's northwestern tile, and the piece stays plain ground with no
creatures. The chance of each piece is `#gen_piece_odds` percent, set by tier
in `build`: 50 on easy and medium and 60 on hard, where about one piece in six
was out of reach. The report prints which pieces a section got and how many
were dropped, and totals both for the run.

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
band, so a line through one leaves a hole. A band can also take so many
regions that the seeds left over cannot hold every other floor, what rock is
still owed included. Either way the band is laid again from another column,
up to four times, and whatever is still wrong after that is counted in the
report, a hole and a band too big apart.

### 3. Grow

`grow` fills the section with black concrete as unclaimed ground, then every seed
claims its own tile and grows outward in waves.

- A straight step lands **5 waves** later, a diagonal one **7**. That ratio
  approximates the real 1.41 closely enough that blobs come out round rather
  than diamond shaped
- A diagonal step is taken **only where one of the two tiles between holds the
  region already**, one `execute if blocks` per bridge, tested on tiles still
  free. Without that a diagonal lands a tile whose bridges other regions took a
  wave or two earlier, joined to its region by a corner alone, and it is
  painted as a lone spot of one kind inside another. A corner refused goes to
  whichever region reaches it straight on, so every tile meets its region
  along an edge
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
rather than curving the way a boundary between two seeds does. Pinning each
carried region to a **point one tile west of the section** instead would draw
the seam properly, since distance from a point varies by row.

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

The water goes on **one tile of the four round the corner the head stood on**,
the same one for the whole river, so a river is as wide as the line the search
walked and two corners next to each other are two tiles next to each other,
whichever way the line turned between them. A tile past the border is outside
the section and gets nothing, which is what keeps a section to its own ground.

Which tile of the four is settled once per river by `_river_side` after the
walk: south-east first, then south-west, north-east and north-west, and the
first whose tiles carve no prefab and put no water across the seam into the
section before is kept for every corner, so a line with a corner on the west
border cannot shift west. Each choice gives the same river shifted a tile,
still one wide and still joined. A line that can be laid on none of them is
refused, and the loops its walk cut are not counted: a river
that had reached an exit goes back to its last choice as if the exit were a
dead end, and a longest line falling back is given up, the section going
without that river. The report counts the lines refused.

It is cut as a **glaze pointing back the way the head came**, with the branches
the search gave up on in red beside it. That is the search drawn out, and it is
worth having, so y9 keeps it.

What comes up to y15 is the glaze alone, and a fill swaps it there for **light
blue concrete** - a river can then be told from the blue a water region is drawn
in, and the finished section carries none of the search on it. The red is never
lifted at all.

### Strays

Once both rivers are down, `strays` walks every tile of the section and hands
on any **stray**: a tile that meets no other tile of its own region along an
edge, which is what a river leaves when it cuts round the last tile of a thin
part of a region. Growth never makes one, so this is the river's doing alone,
and since a stray shares its region with nothing beside it, handing it on can
strand nothing else and one pass is enough. The regions are read on y5, which
still holds them, and where the river runs is read off y9, so a tile the river
took counts as no one's and the red branches stay out of the way.

The stray goes to the **nearest seed among the regions beside it**, written to
y0 and y5 both. Where none of those regions has a seed here, all of them being
carried over the seam, it copies the tile to its north, or failing that the
first other neighbour that is terrain; with river all round it stays as it is.
Some tiles are never handed on: the wall's rock, since a river cutting a thin
part of the wall would leave a stray beside the cut and handing it on would
open the cut two wide; a lake's water, since water beside a river looks as it
should; and tiles carried over the seam, since they have to match the section
before. The report counts the tiles handed on, and light blue glass on y16
marks each of them.

### 6. Kinds

`kinds` gives every seed the kind its region will be drawn as. There are three
**tiers**, picked by `#gen_difficulty` - 0 easy, 1 medium, 2 hard - and each
has a table of weights:

| tier | ground | rock | wood | iron | water |
|---|---|---|---|---|---|
| easy | 45 | 15 | 15 | 15 | 10 |
| medium | 20 | 30 | 15 | 15 | 20 |
| hard | 0 | 40 | 17.5 | 17.5 | 25 |

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

Every section is also held to a floor of **3 wood, 3 iron, 2 water and 3 rock on
easy and medium, and 4 wood, 4 iron, 2 water and 4 rock on hard**, set per tier
in `build`, and the floors are met without
converting anything. A running count keeps what is still owed to the floors
against how many seeds are left. While there are more seeds than owed, each
draws from the bag; the moment the two are equal the remaining seeds take what
is owed instead, wood first, then iron, water and rock. That keeps the table's
ratios for as long as they can be kept and lands the forced kinds on the last
few seeds, which are random ones anyway.

A seed on the wall is rock and a seed the river marked for a lake is water,
whatever the bag says, and each pays its floor like any other draw. They are
drawn first, the lakes and then the wall, and only then every other seed, so
what they take counts toward the floors before anything else is drawn.

The draw settles **how many** regions each kind gets; `_kind_place` then
gives the placing a nudge. The kinds on the seeds off the wall and the lakes
are gathered up and handed out again: each half of the section's columns gets
one wood region and one iron region, a seed in that half taken at random, or
the free seed nearest the half's middle where it has none, and every other
region of wood or iron, and ground, water and rock, goes to the seeds left, at
random. The counts, and so the floors and the bag, are untouched. Each half
holding some of each keeps a section from putting all its wood at one end,
and the rest is left free to bunch or to leave a stretch without.

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

`validate` floods from the first tile the track is laid on, column 0 of the
entry row, across everything inside the section, **cheapest tiles first**, and
stops the moment it reaches the last: either tile beside the station's first
rail, or the exit tile itself with the station off. Each
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

A cut tile also takes the **region** of the terrain it was filled from: a tile
copying the tile beside it takes that tile's region, and a run filled with one
terrain throughout takes it, tile by tile along the run, from the end it opens
onto. The region is kept on y13 over the tile, and whatever asks which region
a tile belongs to once the cuts are made, the repaints, the supply count and
the repair, reads y13 first and the regions as they grew only where y13 is
empty. So a cut through rock beside a water region is part of that region, and
a repaint of the region repaints the cut with it rather than leaving a strip of
water behind. A tile of river or of ground with nothing to copy belongs to no
region. The cuts are the attempt's, so y13 is cleared at the start of every
attempt.

The same walk measures how much the route **pinches the train**. The train is
a box two long and one wide, standing on a route cell and the one ahead of it
and pointing the way the track runs, and the players cannot pass through it,
so what matters is whether rock closes both of its sides at once: a side is
closed when rock stands beside either of the two cells on that side, and the
cell the box stands on is pinched when both are. Only rock counts; everything
else the players can clear. The section's edges count as rock too: the north
and south edges, since nobody gets round the train past the edge of the map,
and the east edge, since what stands past it is not built yet. The west edge
is the section before, and is read as what stands there. The box's left is
its own, so it turns with the track at a corner, which needs no case of its
own. Before a station the train runs on from the last rail onto the station's
first, so the box standing on those two is judged as well, with the building
beside the rail counting as rock. A run of consecutive pinched cells costs its
length cubed, so one long pinch weighs far more than the same length broken
up, and two short runs a cell apart score the same as one long one, which is
what a box two long makes true. The section's score is the sum over its runs.

The tier sets a ceiling on that score and hard sets a floor as well. Over the
ceiling the section is not thrown away. First, a run with a cell within two
tiles of either end of the route, the entry tile or a goal tile, is opened
from that end, since a pinch there can leave the second route no way off the
tile both routes share, one such run a round; only where no run lies there,
or its rock cannot be cut, is the longest run **opened up** from its exit end.
Either way the
rock along one side of it is cut back from the end just far enough that the
section as a whole would pass, beside each opened cell and the cell ahead of
it, the other runs counted, and on hard never so far that the floor is lost;
the side taken is whichever has less rock along those boxes, never one with
none, and never a side that faces out of the section, since the edge cannot
be cut; then the route is found again, and the score taken afresh, for up to
four rounds. Under hard's floor is a reroll like a cheap route. The bands:
easy allows no pinch at all; medium allows 16, two single rows of rock either
side far enough apart not to touch, at 8 each, since the train is pinched on
the cell before such a row and on the row itself; hard wants at least 8, one
such row, and allows up to 216, a corridor five rows long, which is six cells.
Two short corridors a row apart count as the one long one, so hard's ceiling
is as much about spacing as about length.

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
The route may run along column 0 like any other, but nothing in the section
before is ever cut for it: the ring is also what tells the relief that a tile
lies outside the section, and rock there counts as closed but never as a side
to open.

The route is then judged by **what it costs a rail**, not by its total. The time
the players get is the rails they lay, so a longer way across is not a harder
one on its own: a zig-zag buys the time to match its cost. What a longer way is
is more rails out of the same supply and more time at the same pace, so the
cost a rail is raised by `#gen_rail_pen` percent - 1 - for every rail past a
straight crossing, 29 rails up to the station or 32 with it off. The figure is
kept in hundredths of a point a rail
so that it stays a whole number.

A section is usable when the exit was reached and that figure is at least the
tier's floor; the ceiling is held to the cheapest way across once the second
route is found (below), since a first route over the ceiling can still have a
cheaper way beside it, while one under the floor never has. The bands are set
in `build`: 1.55 to 2.20 on easy, 1.60 to 2.50 on medium and 2.20 to 3.00 on
hard. Both medium's and hard's were measured on the cheapest way across,
pieces and all, over 99 and 98 sections: medium's tenth and ninetieth
percentiles came to 1.60 and 2.49 and its band is set on them, hard's to 2.07
and 2.87 and its band set at 2.20 to 3.00 from that; easy's is a placeholder
until a batch has printed it. A tier whose band is being measured lets its routes through
whatever they cost, which is `#gen_rate_free` in `build`, off on every tier
while none is being measured. Wood and iron
need no check here, since the floors in `kinds` guarantee them. If the section
fails, every seed's kind is rolled again and it is painted again, keeping the
regions and the seeds. Up to 5 attempts.

The figure is taken on the cheapest route by total cost, which is the natural
line across. A longer detour can average less a rail, so this overstates a
little what a player padding their route with ground could get. The true
lowest-average path is out of reach in commands, and without a rail budget it is
not even well defined, since a loop through ground drags any average toward 1.

### The second route

Once the section has settled on its route, `second` finds a **second way
across** for the players to get round the train by: between the same two tiles
as the first, keeping off every cell of the first route where the train is
pinched, and walking the first route everywhere else. A first route that
pinches nowhere has nothing to be got round, and the second route is the first.

The first route is copied up to y18 and its pinched cells marked there, and
two things are drawn round it: a **band**, white on the eight tiles beside each
of its cells, and a **zone**, black on every tile within four steps along the
grid of one of its pinched cells, a diamond round each pinch, light gray where
the two fall on the same tile. The cell at either end of a pinched run three
or more long draws no diamond, though it is still a pinched cell the second
route keeps off. Rock is never cut for the second route in either: the band's
rock is what pinches the first route, and the zone keeps the two routes'
pinches apart with rock between them.

The way is found along the first route (`_second_find`). The trace of the first
route numbers its tiles from the last to the entry, and the search goes along
them in that order, each tile keeping the least a way to it has cost. From a
tile the second route may stand on it goes on to the next, for nothing where
the next may be stood on too, and, wherever a pinched tile lies within
`#gen_detour_max` tiles ahead, it searches off the route (`_sec_bfs`) for
**detours** of no more than `#gen_detour_max` tiles, 20, that come back onto a
later tile of the route. A detour costs a thousand for every rock tile it cuts
and one for every tile it runs, so the way chosen cuts no rock if any way
round keeps every detour within the limit, and takes the fewest tiles off the
route among those; failing that it cuts the least rock that will do, and runs
the fewest tiles for it. The limit is there so that players caught on the wrong
side of the train can get round to the other in good time. The way is then laid
down on y17 as a flood would have left it and walked back by the same trace as
the first route, which measures it, marks the rock it runs through to be cut
and draws it. Where no way keeps within the limit even cutting rock, there is
no second way.

The second route is then judged for pinching like the first and opened up the
same way, against the tier's ceiling only, never the floor, and rock beside
the first route is never opened for it, since that rock is what pinches the
first. It is never judged for cost. On y17 it is drawn in **purple**, with
**pink** wherever the two routes share a tile, and the first route stays red.
A section with no pinch on its first route gets the first route back as its
second, all pink, which is what the rule comes to there.

It runs inside the attempt loop, on every attempt the track got across. Where
it finds no second way, `_second_retry` finds the first route again, opens
the pinched cells of it within two tiles of either end, from that end and no
further, whatever the score, since what the second route needs is a way off
the shared tile rather than a lower score, judges
the first route afresh, which can make the attempt a reroll if the opening
took it under its floor or its band, and looks for the second way once more;
the report counts the sections whose ends were opened. A
section where even that finds no second way is a **reroll** like a cheap
one, counted on the rerolls line, while `#gen_second_reroll` is set, which it
is. Drawing the kinds again leaves the wall where it
is, and the wall's rock is mostly what stands in the second way's way, so a
section that has found no second way twice is built again for every attempt
after (`_wall_relay`): the regions are put back as they grew, from a copy
growing them left on y12, and the wall on hard, the rivers and the stray sweep
are done again in the same order as the first time, keeping only the seeds. The
report counts the walls laid again. Off, the section ships without one, and the band the way was looked for
in is left on y19 to be looked at: the first route in red, its pinched cells
in gray, the band in white, the no-cut zone in black and light gray where the
two meet. The report gives the second route's tiles off the first route and
its longest detour, and what each route costs to lay, priced tile by tile the
way the flood prices the first (`_price_routes`).

Rock the second route cuts becomes terrain the track can be laid over, and a
passage cut through the wall can make a way across cheaper than the first
route was. So on an attempt whose second route cut or opened anything,
`_cheapest` sets the routes aside a layer up, floods the section again from
the entry the way `validate` does, counts the rails of what it finds and works
out its cost a rail with the same sums (`_rate_calc`); on any other attempt
the cheapest way is the first route. A section whose cheapest way falls
outside the tier's band is a **reroll**, counted on the rerolls line as
cheaper once cut where it is under the floor and too expensive where it is
over the ceiling, which is the only place the ceiling is judged. The first route stays the
one drawn and the one the supply is counted for; the report prints the
cheapest way beside both routes' costs.

Last of all, on the section as it ships, after the supply's repaints, every
tile of the cheapest way across has to have **water** within
`#gen_water_reach` steps, 25. `_water_check` marks the cheapest way's tiles,
from the walk back in `_cheapest` where that ran and from the first route
where it did not, and `_water_area` walks out from every tile of water, river
or lake or region, a wave a step, north, south, east and west over ground,
wood and iron, rock and the station's building standing in the way, marking
what it reaches on y14. It covers this section and the last 25 columns of the
section before, whose water the players can walk to over the seam, inside a
ring of glass so that it goes no further. A section with any tile of the way
left unmarked is a **reroll**, counted on the rerolls line as water too far,
while `#gen_water_reroll` is set, which it is; the report prints how many
tiles were too far.

### 9. Supply

`supply` checks that the section holds enough wood and iron within reach of
the route to lay it. It runs inside the attempt loop, on every attempt that is
usable so far, and once more after the loop for a section that ships from an
attempt that never got that far. Each route needs one wood and one iron for every rail and
a bridge for every tile of water under it, a bridge being one wood
(`#gen_bridge` picks wood or iron, for a biome whose bridges are iron), and
the section is held to the costlier of the two routes on each count, with a
fifth on top (`#gen_supply_over`, 120 percent, rounded up).

What is within reach is found by a third mode of the flood, set out from every
tile of the first route at once: water costs one, the bridge to it, rock is
never crossed, and everything else is free. Every seed the flood got to has
the water on the cheapest way from the route to it counted by walking the
flood's marks back. Supply is counted on the finished terrain, tile by tile:
a reached tile of wood or iron counts to its region's seed where the region
is one of this section's own drawn as that kind, and otherwise, carried over
the seam or cut into a resource, as a free tile. Nothing under a river counts.
Regions are then taken **cheapest first**: the free tiles, then each reached
region of wood or iron by its water count, each taken only while its kind is
still short, its tiles added and the water on the way to it charged as
bridges and marked, so that a crossing two regions share is paid once. The
bridges to a region taken later can raise what the other kind needs after a
region of it was passed over for having enough, so while a kind is still
short the regions not yet taken are gone through again, for as long as a
pass takes something.

Before the adding up, the resources have to come along at a steady rate as
well, and that is counted in **tiles**, column by column. `_col_scan` counts,
for each of the section's 32 columns, the wood tiles and the iron tiles the
supply flood left its mark over, which is every one the players can get to.
The targets are worked out in `load` from the section's size: a **seed's
worth** is the tiles a region averages, 512 tiles over 18 seeds, rounded to
28, and a window wants `#gen_spread_min` of them, 57.

Three things are asked of the section. Its **tail**, its last fifteen
columns, must hold a seed's worth of wood and of iron, so that every window the
section after is judged by starts with some of each on this side of the seam.
Every **thirty-column window** ending in this section, taken one column at a
time and never starting before the map does, must hold two seeds' worth of
each (`#gen_spread_span`, `#gen_spread_min`); the section before counts for its
part through the 29 columns it stored when it finished. And the **totals**
within reach must cover what the routes need.

They are put right by one **search**, `_repair`. The section is given a score,
the tiles every window falls short of each resource, plus the tail's, plus the
totals' weighed `#rep_total_weight` times, 8, since a gap is short in every
window it falls in but in the totals only once. The totals are counted the
way the supply count counts them: a region whose seed the flood never reached,
or with more than eight tiles of water on the way to it, is one the count
never takes, so its tiles count toward the windows but not the totals, and
the flag goes with the region through every change tried. The score is taken
from the columns: the section's own are counted once a step, along with how
many tiles
within reach every region holds in each column, and a change is scored by
adding or taking that region's columns rather than repainting anything. Each
step tries every change that turns a region into wood or into iron: any region
within reach of another kind, never rock, a wall, a lake, or a region the first
route runs through, since that would change what the route was judged to cost,
either turned outright, where its own kind holds more regions than its floor,
or swapped with a region of the kind it becomes, reached, which takes its old
kind in return and so keeps the section's mix. A region the first route runs
through may still go from wood to iron or from iron to wood, outright or in a
swap either side, since the route pays the same for a tile of either.
Only a kind that falls short somewhere has regions turned into it, since a
trade of the two resources that helps one is tried from that one's side, and
a change that leaves the other resource alone has only its own kind scored
again. The change that lowers the score most is made, the columns and what the routes need
counted afresh, and another step taken, up to eight; the search stops as soon as
the score is nothing or no change lowers it. Since every change lowers the
score it cannot go round in circles, and it changes no more than it has to, so
a stretch without wood that the windows allow is left as it is. A region the
second route runs through may be changed, and if it was water the second
route's bridges change with it. A repaint goes onto y15 and y5 both, leaving
the river where it crosses the region, with magenta glass over it on y16.

The columns are counted by `_rep_scan` into fake players, one a column a kind,
and a region's by column into the scores `dr_c0` to `dr_c31`, so that scoring
a change is a run of additions with no lists or macros in it; those functions
are written out in full by `utils/make_repair.py`, which has to be run again if
the section width, the window or the tail changes.

After the search the tail and the windows are judged:
`_spread_pass` feeds the section before's 29 columns and this section's 32
through a **first-in first-out list** in storage, adding each column taken in to
a running total of wood and one of iron and dropping the oldest from both once
the list holds 30, and counts the windows left wanting. A section is let off a
few: it is a **reroll** like a cheap one, counted on the rerolls line, when
more than a fifth of the windows it judged are wanting, which is 6 of 32 or
none of the first section's 3 (`#gen_window_pass`, 80, rounded down), or when
any window holds less than four fifths of what a window wants of either kind,
46 tiles (`#gen_window_deep`, 80, as `#gen_spread_deep`), while
`#gen_window_reroll` is set, which it is; the repaints go with the
attempt, glass and all. Only the attempt that ships adds to the run's totals.
The report prints
those, whether the tail is wanting, whether the totals are short, and the
search's own swaps, repaints and the score it left. Where windows are left
wanting it lists them too, each by the column of the section it ends on with
the wood and iron it holds, and after them every column fed through, the
section before's 29 first, and what the tiles either side of the seam are,
the section before's last ten columns and its own first ten: rock, river, out
of reach, and otherwise ground, wood, iron or water by whether the region is
one the first route runs through, another of the section's own or none of its
own. `_rim_look` counts them for every attempt while the report is on, and
`_rim_keep` keeps the section before's once at the start of the section. Each
attempt counts its columns once more when it is done, and the attempt that
ships stores them for the section after.

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
every tile the route cut through rock, yellow over every tile cut to open a
pinch, light blue over every stray tile the sweep after the rivers handed to
another region, magenta over every tile repainted for the supply, and the
station's rails, buffer stop and bricks, and
**y=17** holds the cheapest route across in red glass,
the second way across in purple, and pink where the two share a tile, inside a
grey ring. Where no second way was found, **y=19** keeps the band it was
looked for in: the first route red, its pinched cells gray, the free band
white, the no-cut zone black and light gray where the two meet.

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
