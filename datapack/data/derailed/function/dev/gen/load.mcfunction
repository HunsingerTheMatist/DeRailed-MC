
# Sets up what the generator needs at load

# The wave delays are 5 and 7, so eight tags cycle without a delay ever landing
#  back on the wave being woken
scoreboard players set $Eight dr_const 8

# Straight on counts three times against a turn, where a river picks its way
scoreboard players set $Three dr_const 3

# For rounding a division to the nearest whole number, done in halves
scoreboard players set $Two dr_const 2

# For flipping a difference to its absolute value
scoreboard players set $NegOne dr_const -1

# For keeping a rate in hundredths, since a score is a whole number
scoreboard players set $Hundred dr_const 100

# What a bag of kind weights holds between its kinds, in hundredths of a percent
scoreboard players set $TenThousand dr_const 10000

# How many tiles a section has
scoreboard players set $SectionTiles dr_const 512

# How many seeds a section is scattered with
scoreboard players set $SectionSeeds dr_const 18

# A section is built on four layers, each one laid out from the one below it
# y0 holds the block each region grew as, and only the stray sweep after the
#  rivers ever changes it, so whatever asks which region a tile belongs to gets a
#  straight answer however far along the section is
# y5 is what the river reads and then where the kinds are drawn, one after the
#  other. It is laid out as a copy of y0 before the river is cut, and by then
#  every section before it has had its kinds painted there, so a river looking
#  west across a seam compares against the section before as it was drawn rather
#  than as it grew - which is the same thing a region carried over the seam is
#  standing in. Nothing reads it as regions again afterwards, so painting swaps
#  them for kinds in place
# y9 is y5 with the rivers cut into it, and the branches the search gave up on
#  drawn over that. The second river reads it to find the first, the stray sweep
#  reads where the river runs off it, and otherwise it is only there to be
#  looked at
# y12 is y0 as the regions grew, kept for a section that has to be built again
#  from them
# y13 holds, over every tile a cut filled from terrain next to it, the region
#  that terrain belongs to, so that the tile counts and is repainted as part of
#  it; it is cleared at the start of every attempt, since the cuts are the
#  attempt's
# y15 is the section as it is meant to be seen: y5 with the river lifted onto it
#  and the station drawn over it, with the glass that marks what was cut, handed
#  on or repainted one above along with the station's rails, the flood that
#  checks it running two above and, three above, the band
#  round the first route that the second route is priced by while it is found,
#  and then the routes kept aside while the supply is checked; four above, that
#  band is left standing where no second route was found, to be looked at; and
#  five above, the bridges to the resources while the supply is checked, apart
#  from the routes so that clearing them takes none of the routes with them

# The kind each seed grows its region as
scoreboard objectives add dr_kind dummy "DeRailed Region Kind"

# Which of the section's regions a seed is, so two of them that roll the same
#  kind can still be told apart while the river is being cut
scoreboard objectives add dr_id dummy "DeRailed Region Id"

# Light blue concrete is left out, since it is what the river is drawn in on the
#  visible layer and a region in it would read as water at a glance
data modify storage derailed:gen ids set value ["white_terracotta", "orange_terracotta", "magenta_terracotta", "light_blue_terracotta", "yellow_terracotta", "lime_terracotta", "pink_terracotta", "gray_terracotta", "light_gray_terracotta", "cyan_terracotta", "purple_terracotta", "blue_terracotta", "green_terracotta", "red_terracotta", "black_terracotta", "brown_terracotta", "white_concrete", "orange_concrete", "magenta_concrete", "yellow_concrete", "pink_concrete", "cyan_concrete", "purple_concrete", "green_concrete", "red_concrete", "white_wool"]

# The block each kind is drawn in, which 'dev/gen/_read_kind' reads back: none of
#  these may be one of the ids above, or a region would answer as a kind
# A region carried over the western seam grows straight into its kind, taking the
#  ids from 26 on, so these are the tail of the ladder in 'dev/gen/_set_id' as
#  well and the two lists have to stay in step
data modify storage derailed:gen kinds set value ["lime_concrete", "brown_concrete", "light_gray_concrete", "blue_concrete", "gray_concrete"]

# The wave a tile on the eastern edge was taken on, carried to the section after
#  so a blob arrives there when it would have done anyway
scoreboard objectives add dr_wave dummy "DeRailed Claim Wave"
scoreboard objectives add dr_wake dummy "DeRailed Seam Wake"

# Which level of the least-cost flood a rock tile it came up against is stepped
#  onto on, a level being a thousand of cost
scoreboard objectives add dr_level dummy "DeRailed Flood Level"

# What a river's search hangs on its markers: how deep in choices a tile was
#  laid, how far into the search, and the way the head arrived
scoreboard objectives add dr_depth dummy "DeRailed River Depth"
scoreboard objectives add dr_step dummy "DeRailed River Step"
scoreboard objectives add dr_dir dummy "DeRailed River Heading"

# What the supply check hangs on a seed: how many tiles of its resource the
#  flood got to in its region, and how many tiles of water lie between the
#  route and it
scoreboard objectives add dr_size dummy "DeRailed Region Size"
scoreboard objectives add dr_bridge dummy "DeRailed Region Bridges"

# What the search for the second way across hangs on the first route's tiles
#  and on the tiles it steps onto: the least a way to a route tile has cost,
#  the stretch it came from and the way the tile a detour stepped off lies,
#  the rock cut to reach a tile, and the stretch of the route a tile is in
scoreboard objectives add dr_best dummy "DeRailed Second Route Cost"
scoreboard objectives add dr_from dummy "DeRailed Second Route From"
scoreboard objectives add dr_via dummy "DeRailed Second Route Via"
scoreboard objectives add dr_rock dummy "DeRailed Second Route Rock"
scoreboard objectives add dr_str dummy "DeRailed Second Route Stretch"

# What the report counts of the tiles either side of each seam
scoreboard objectives add dr_rim dummy "DeRailed Seam Tiles"

# The wood, iron and track the ordered supply check counts at each level
scoreboard objectives add dr_ord dummy "DeRailed Supply Order"
scoreboard objectives add dr_olev dummy "DeRailed Region Level"

# How many of a region's tiles within reach each of the section's columns
#  holds, for the repair
function derailed:dev/gen/_rep_objectives

# How far apart section corners sit
scoreboard players set $SectionWidth dr_const 32

# Whether sections get a river at all
# A river crossing a boundary sits on top of what the seam left there, so turning
#  this off is how the terrain either side of a seam gets looked at on its own
scoreboard players set #gen_rivers dr_var 1

# Whether a section stops as soon as its first river is cut, keeping the corner
#  markers and leaving the regions in the blocks they grew as
# Where the water lands is not where the walk stood, so reading a river back off
#  the map is guesswork; this leaves both the line and the boundaries it was
#  following there to be read outright
scoreboard players set #gen_riv_hold dr_var 0

# The longest a river may run before the search gives that way up
# A section 32 wide could be crossed in far fewer, but a river only turns where a
#  boundary does, so it spends length getting to where it can leave rather than
#  going straight there; the room is for that rather than for wandering
scoreboard players set #gen_riv_max dr_var 80

# The shortest the first river may be and still be worth keeping
# One that reaches the far border before then is turned back to look for a
#  longer way out
scoreboard players set #gen_riv_min dr_var 20

# The least a section's rivers may come to between them: a first river this
#  long stands alone, and a shorter one gets a second held to the difference
scoreboard players set #gen_riv_pair dr_var 40

# The shortest the second river may be whatever the first came to, so that a
#  long first river does not leave it a puddle
scoreboard players set #gen_riv_2nd dr_var 10

# How many columns the second river sets out from where the first did, so that
#  it does not run into it at once
scoreboard players set #gen_riv_apart dr_var 6

# Which tier every section is built to: 0 easy, 1 medium, 2 hard
# It picks the weights the kinds are drawn with and what the cheapest way across
#  may cost a rail, and can be changed between one section and the next
scoreboard players set #gen_difficulty dr_var 1

# Which tier every section of a test run is built to, or -1 for one on each
#  tier, easy, medium, then hard
scoreboard players set #gen_test_tier dr_var 2

# How many test runs 'dev/gen/test_batch' makes, one a tick
scoreboard players set #gen_batch_size dr_var 33

# How much more expensive a rail every rail past a straight crossing makes the
#  percent: a longer section is more rails out of the same supply and more time
#  at the same pace, so its cost a rail is not the whole story
scoreboard players set #gen_rail_pen dr_var 1

# How many tiles the second way across may run off the first route in one
#  detour round a pinch, so that players stuck on one side of the train can get
#  to the other in good time
scoreboard players set #gen_detour_max dr_var 20

# Which route the flood is finding: 0 the first, 1 the second, 2 the way from
#  the first route out to the resources
scoreboard players set #cost_mode dr_var 0

# How a pinched run is opened: how many of its cells, or -1 for as many as
#  bring the section under its ceiling; from which end, 0 its exit end and 1
#  its entry end; and whether a run against an end of the route is opened only
#  at its cells by that end
scoreboard players set #pinch_take dr_var -1
scoreboard players set #pinch_from dr_var 0
scoreboard players set #pinch_near dr_var 0

# How many times over the repair weighs a tile the totals are short against a
#  tile a window is short, since a gap is short in every window it falls in
#  but in the totals only once
scoreboard players set #rep_total_weight dr_var 8

# Which resource a bridge over water is built from, 1 wood or 2 iron, which is
#  what the water under a route and on the way to a resource is charged to
scoreboard players set #gen_bridge dr_var 1

# How much of what the routes need the section has to hold within reach, in
#  percent, so that there is some to spare
scoreboard players set #gen_supply_over dr_var 120

# How wide a window of columns has to hold '#gen_spread_min' seeds' worth of
#  wood tiles and of iron tiles within reach, wherever along the map it is
#  taken, so that neither runs dry for long
scoreboard players set #gen_spread_span dr_var 30
scoreboard players set #gen_spread_min dr_var 2

# A seed's worth is the tiles a region averages, a section's tiles over its
#  seeds, rounded to the nearest; a window wants '#gen_spread_min' of them, and
#  a section's last fifteen columns one
scoreboard players operation #gen_seed_tiles dr_var = $SectionTiles dr_const
scoreboard players operation #gen_seed_tiles dr_var *= $Two dr_const
scoreboard players operation #gen_seed_tiles dr_var += $SectionSeeds dr_const
scoreboard players operation #gen_seed_tiles dr_var /= $SectionSeeds dr_const
scoreboard players operation #gen_seed_tiles dr_var /= $Two dr_const
scoreboard players operation #gen_spread_need dr_var = $SectionTiles dr_const
scoreboard players operation #gen_spread_need dr_var *= #gen_spread_min dr_var
scoreboard players operation #gen_spread_need dr_var *= $Two dr_const
scoreboard players operation #gen_spread_need dr_var += $SectionSeeds dr_const
scoreboard players operation #gen_spread_need dr_var /= $SectionSeeds dr_const
scoreboard players operation #gen_spread_need dr_var /= $Two dr_const

# A section is let off a few wanting windows: '#gen_window_pass' percent of
#  them have to hold what a window wants, and every one of them has to hold
#  '#gen_window_deep' percent of it, rounded to the nearest
scoreboard players set #gen_window_pass dr_var 80
scoreboard players set #gen_window_deep dr_var 80
scoreboard players operation #gen_spread_deep dr_var = #gen_spread_need dr_var
scoreboard players operation #gen_spread_deep dr_var *= #gen_window_deep dr_var
scoreboard players operation #gen_spread_deep dr_var *= $Two dr_const
scoreboard players operation #gen_spread_deep dr_var += $Hundred dr_const
scoreboard players operation #gen_spread_deep dr_var /= $Hundred dr_const
scoreboard players operation #gen_spread_deep dr_var /= $Two dr_const
scoreboard players operation #gen_tail_need dr_var = #gen_seed_tiles dr_var

# Whether a section with no second way across is rerolled; off, it ships
#  without one and leaves the band the way was looked for in a layer up, to be
#  looked at
scoreboard players set #gen_second_reroll dr_var 1

# Whether a section that leaves a window of columns wanting wood or iron after
#  the repair is rerolled; off, it ships as it is
scoreboard players set #gen_window_reroll dr_var 1

# How many steps over land every tile of the cheapest way across may be from
#  water, and whether a section with a tile further out is rerolled; off, it
#  ships as it is
scoreboard players set #gen_water_reach dr_var 25
scoreboard players set #gen_water_reroll dr_var 1

# How much wood the players are taken to arrive with, what share over the
#  bridges and track below it the wood they can reach has to cover before land
#  behind more water counts, in percent, and whether a section they cannot get
#  their wood through in that order is rerolled; off, it ships as it is
scoreboard players set #gen_order_allow dr_var 0
scoreboard players set #gen_order_pct dr_var 120
scoreboard players set #gen_order_reroll dr_var 1

# How many regions may be repainted as wood, one at a time, to get the players
#  their wood in order before the section is rerolled
scoreboard players set #gen_order_fixes dr_var 3
scoreboard players set #order_on dr_var 0

# How many spots a piece is tried at before the section goes without it
scoreboard players set #gen_piece_tries dr_var 30

# How many attempts a section gets on one set of regions, and how many times it
#  may be thrown out and laid again from new seeds before it ships as it is
scoreboard players set #gen_attempt_count dr_var 3
scoreboard players set #gen_fresh_max dr_var 2
scoreboard players set #gen_fresh dr_var 0

# Whether every section ends in a station, standing against the eastern edge on
#  the row the track leaves by and reaching into the section after
# Its tiles are laid in bedrock and obsidian on the layers the regions are read
#  from, bedrock for its ground, open to the players and the track alike, and
#  obsidian for its building, which nothing crosses, so that nothing grows,
#  cuts or paints there and every check can tell them at a glance; what it
#  looks like goes on the visible layer and the one above it
scoreboard players set #gen_station dr_var 1

# How much of one seed's share of the bag a draw takes off the kind drawn, in
#  percent, to be handed out to the others
# The whole share holds every kind to its weight within a region or so; half
#  lets sections differ while still keeping any kind from running away
scoreboard players set #gen_bag_take dr_var 50

# Whether a seed gets an armour stand standing over it
# They are only there to be looked at, and a benchmark builds enough sections for
#  hundreds of them to pile up and tick through the timings, so it turns them off
scoreboard players set #gen_marks dr_var 1

# Whether a finished map says how it went
# A run being timed turns it off, since chat is answered by the client and a few
#  thousand lines of it would be measured along with the generating
scoreboard players set #gen_report dr_var 1

# How close two seeds may be placed
# Higher spreads them evenly and grows regions of a size, lower lets them cluster
#  and grows regions that vary, which is the knob for how blotchy a section looks
scoreboard players set #gen_spacing dr_var 4

# How many waves of a head start a carried region gets
# Its rows set off at the wave the section before took them on, less this, so
#  the shape of how far back its seed was is kept while it stays able to hold
#  ground against seeds that start from nothing
scoreboard players set #gen_seam_lead dr_var 3
