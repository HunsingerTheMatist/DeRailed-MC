
# Sets up what the generator needs at load

# The wave delays are 5 and 7, so eight tags cycle without a delay ever landing
#  back on the wave being woken
scoreboard players set $Eight dr_const 8

# Straight on counts three times against a turn, where a river picks its way
scoreboard players set $Three dr_const 3

# For flipping a difference to its absolute value
scoreboard players set $NegOne dr_const -1

# A section is built on four layers, each one laid out from the one below it
# y0 holds the block each region grew as and is never drawn over, so whatever asks
#  which region a tile belongs to gets a straight answer however far along the
#  section is
# y5 is what the river reads and then where the kinds are drawn, one after the
#  other. It is laid out as a copy of y0 before the river is cut, and by then
#  every section before it has had its kinds painted there, so a river looking
#  west across a seam compares against the section before as it was drawn rather
#  than as it grew - which is the same thing a region carried over the seam is
#  standing in. Nothing reads it as regions again afterwards, so painting swaps
#  them for kinds in place
# y9 is y5 with the rivers cut into it, and the branches the search gave up on
#  drawn over that. The second river reads it to find the first, and otherwise
#  it is only there to be looked at
# y15 is the section as it is meant to be seen: y5 with the river lifted onto it,
#  with the flood that checks it running two above

# The kind each seed grows its region as
scoreboard objectives add dr_kind dummy "DeRailed Region Kind"

# Which of the 26 regions a seed is, so two of them that roll the same kind can
#  still be told apart while the river is being cut
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

# What a river's search hangs on its markers: how deep in choices a tile was
#  laid, how far into the search, and the way the head arrived
scoreboard objectives add dr_depth dummy "DeRailed River Depth"
scoreboard objectives add dr_step dummy "DeRailed River Step"
scoreboard objectives add dr_dir dummy "DeRailed River Heading"

# How far apart section corners sit
scoreboard players set $SectionWidth dr_const 48

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
# A section 48 wide could be crossed in far fewer, but a river only turns where a
#  boundary does, so it spends length getting to where it can leave rather than
#  going straight there; the room is for that rather than for wandering
scoreboard players set #gen_riv_max dr_var 120

# The shortest the first river may be and still be worth keeping
# One that reaches the far border before then is turned back to look for a
#  longer way out
scoreboard players set #gen_riv_min dr_var 25

# The least the two rivers may come to between them, which is what the second is
#  held to when the first left it short
scoreboard players set #gen_riv_pair dr_var 50

# The shortest the second river may be whatever the first came to, so that a
#  long first river does not leave it a puddle
scoreboard players set #gen_riv_2nd dr_var 10

# How many columns the second river sets out from where the first did, so that
#  it does not run into it at once
scoreboard players set #gen_riv_apart dr_var 10

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
