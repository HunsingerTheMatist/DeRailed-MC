
# Gives every seed the kind its region will be drawn as, and sees that each kind
#  gets at least its floor of regions
# Positioned at the section's corner

# What each floor is still owed, and the total of it
scoreboard players operation #kind_owe_wood dr_var = #gen_min_wood dr_var
scoreboard players operation #kind_owe_iron dr_var = #gen_min_iron dr_var
scoreboard players operation #kind_owe_water dr_var = #gen_min_water dr_var
scoreboard players operation #kind_owe_rock dr_var = #gen_min_rock dr_var
scoreboard players operation #kind_owed dr_var = #kind_owe_wood dr_var
scoreboard players operation #kind_owed dr_var += #kind_owe_iron dr_var
scoreboard players operation #kind_owed dr_var += #kind_owe_water dr_var
scoreboard players operation #kind_owed dr_var += #kind_owe_rock dr_var

# How many seeds are still to be given a kind
execute store result score #kind_left dr_var if entity @e[type=marker,tag=dr_seed,distance=0..]

# All of them draw from one bag, filled for the tier and first charged for what
#  the seam carried in, so that a section whose western strip arrived as one
#  kind draws that much less of it
function derailed:dev/gen/_bag_fill
function derailed:dev/gen/_bag_bleed
scoreboard players operation #bag_n dr_var = #kind_left dr_var
function derailed:dev/gen/_bag_share

# The seeds whose kind is already settled are drawn first, the lakes a river
#  ran out against and then the wall, so that what they take counts toward the
#  floors before any other seed is drawn, and none of them can take a place a
#  floor was still owed
execute as @e[type=marker,tag=dr_seed,tag=dr_lake,distance=0..] run function derailed:dev/gen/_kind_seed
execute as @e[type=marker,tag=dr_seed,tag=dr_wall,tag=!dr_lake,distance=0..] run function derailed:dev/gen/_kind_seed
execute as @e[type=marker,tag=dr_seed,tag=!dr_wall,tag=!dr_lake,distance=0..] run function derailed:dev/gen/_kind_seed

# The draw settles how many regions each kind gets; where they go across the
#  section is settled after, so that the wood and the iron are spread along it
function derailed:dev/gen/_kind_place
