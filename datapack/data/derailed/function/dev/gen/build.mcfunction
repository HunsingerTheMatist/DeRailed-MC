
# Builds one whole section, retrying the kinds up to 5 times until the cheapest
#  way across costs what the tier asks
# Positioned at the section's corner

# The tier sets what the cheapest way across may cost a rail, in hundredths of a
#  point, counting ground 1, wood or iron 2 and water 4 a tile and a little more
#  for every rail past a straight crossing: under the floor is too easy a
#  section and over the ceiling too hard
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_min dr_var 155
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_max dr_var 220
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_min dr_var 165
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_max dr_var 260
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_min dr_var 265
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_max dr_var 330

# Whether a route outside that band is let through rather than rerolled, which
#  is how a tier's band is measured: hard's is being taken afresh
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_free dr_var 0
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_free dr_var 0
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_free dr_var 1

# And how much the route may pinch the train, a run of n pinched boxes
#  counting n cubed: over the ceiling is opened up rather than thrown away, and
#  hard wants some
# Easy allows none, medium two single rows of rock either side far enough apart
#  not to touch, two boxes each, and hard from one such row up to a corridor
#  five long, which is six boxes
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_pinch_max dr_var 0
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_pinch_min dr_var 0
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_pinch_max dr_var 16
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_pinch_min dr_var 0
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_pinch_max dr_var 216
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_pinch_min dr_var 8

# And the fewest regions of each kind a section may have, met by holding back
#  the last seeds drawn for whatever is still owed; rock's, since rock is what
#  makes a section hard to move about in rather than just expensive to cross
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_rock dr_var 4

# And the fewest wood and iron regions, since the routes are laid from them:
#  hard's routes cost the most and its rock leaves the least to repaint, so it
#  holds one more of each
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_wood dr_var 3
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_iron dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_wood dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_iron dr_var 3
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_wood dr_var 4
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_iron dr_var 4

# And the fewest water regions
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_water dr_var 2
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_water dr_var 2
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_water dr_var 2

# What the report reads about the second route and the supply starts from
#  nothing, since a section the track never gets across skips both
scoreboard players set #sec_reached dr_var 0
scoreboard players set #sup_wood dr_var 0
scoreboard players set #sup_iron dr_var 0
scoreboard players set #need_wood dr_var 0
scoreboard players set #need_iron dr_var 0
scoreboard players set #sup_bridges dr_var 0
scoreboard players set #sup_short dr_var 0
scoreboard players set #gen_spread_gaps dr_var 0

# The row the track leaves by comes first, since the station stands on it and
#  everything else grows round the station: its tiles are laid before a seed is
#  placed, and its edge leaves notes for the section after to read as ground
function derailed:dev/gen/route
execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_station_stamp with storage derailed:gen r
execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_station_notes with storage derailed:gen r

function derailed:dev/gen/scatter
function derailed:dev/gen/grow

# Hard gets a band of rock across it for the route to have to cut through,
#  picked from the regions once they have grown so that it has no gap
execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/wall

# The kinds layer starts out as the regions exactly as they grew, which is both
#  what the river reads and what painting swaps out from under itself
# The sections before have theirs drawn in kinds by now, so a river running along
#  the seam compares like with like across it
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict

# A section whose rivers found nowhere to start goes on without them, counted
#  by the search, since nothing a reroll does can put a river into it
execute if score #gen_rivers dr_var matches 1 run function derailed:dev/gen/rivers

# Held for a look at the river, the section stops here with nothing drawn over it
execute if score #gen_riv_hold dr_var matches 1 run return 0

# A tile left with no edge to another of its own region, which is what a river
#  can leave behind, is handed to a region beside it before the kinds are drawn
function derailed:dev/gen/strays

scoreboard players set #gen_attempts dr_var 5
function derailed:dev/gen/_build_attempt

# Whether there is enough wood and iron within reach to lay either route
execute positioned ~ ~15 ~ run function derailed:dev/gen/supply

# The notes left along the eastern edge only learn their kind once the section is
#  settled, since a reroll would have changed it under them
execute as @e[type=marker,tag=dr_edge,tag=!dr_prefab,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_edge_kind
