
# Builds one whole section, retrying the kinds up to 5 times until the cheapest
#  way across costs what the tier asks
# Positioned at the section's corner

# The tier sets what the cheapest way across may cost a rail, in hundredths of a
#  point, counting ground 1, wood or iron 2 and water 4 a tile and a little more
#  for every rail past a straight crossing: under the floor is too easy a
#  section and over the ceiling too hard
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_min dr_var 155
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_max dr_var 220
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_min dr_var 185
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_max dr_var 250
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_min dr_var 265
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_max dr_var 330

# And how much the route may pinch the train, a run of n pinched windows
#  counting n cubed: over the ceiling is opened up rather than thrown away, and
#  hard wants some
# Easy allows none, medium two single rows of rock either side far enough apart
#  not to touch, and hard from one such row up to a corridor five long, which is
#  seven windows
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_pinch_max dr_var 0
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_pinch_min dr_var 0
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_pinch_max dr_var 54
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_pinch_min dr_var 0
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_pinch_max dr_var 343
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_pinch_min dr_var 27

# And the fewest rock regions, since rock is what makes a section hard to move
#  about in rather than just dear to cross
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_rock dr_var 4

function derailed:dev/gen/scatter
function derailed:dev/gen/route
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

scoreboard players set #gen_attempts dr_var 5
function derailed:dev/gen/_build_attempt

# The notes left along the eastern edge only learn their kind once the section is
#  settled, since a reroll would have changed it under them
execute as @e[type=marker,tag=dr_edge,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_edge_kind
