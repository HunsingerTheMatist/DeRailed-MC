
# Builds one whole section, retrying the terrain up to 5 times until the track
#  can get across
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

# And the fewest rock regions, since rock is what makes a section hard to move
#  about in rather than just dear to cross
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_rock dr_var 4

function derailed:dev/gen/scatter
function derailed:dev/gen/route
function derailed:dev/gen/grow

# The kinds layer starts out as the regions exactly as they grew, which is both
#  what the river reads and what painting swaps out from under itself
# The sections before have theirs drawn in kinds by now, so a river running along
#  the seam compares like with like across it
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict

scoreboard players set #riv_done dr_var 1
execute if score #gen_rivers dr_var matches 1 run function derailed:dev/gen/rivers

# Nothing a reroll does can put a river into a section that would not take one,
#  so there is no point trying the terrain five times over
execute if score #riv_done dr_var matches 0 run return run scoreboard players add #gen_failed dr_var 1

# Held for a look at the river, the section stops here with nothing drawn over it
execute if score #gen_riv_hold dr_var matches 1 run return 0

scoreboard players set #gen_attempts dr_var 5
function derailed:dev/gen/_build_attempt

# The notes left along the eastern edge only learn their kind once the section is
#  settled, since a reroll would have changed it under them
execute as @e[type=marker,tag=dr_edge,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_edge_kind
