
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

# How many seeds are still to be given a kind, and how many of them the track
#  runs through
execute store result score #kind_left dr_var if entity @e[type=marker,tag=dr_seed,distance=0..]
scoreboard players operation #kind_all dr_var = #kind_left dr_var
execute store result score #kind_chain dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_chain,distance=0..]
scoreboard players operation #kind_off dr_var = #kind_left dr_var
scoreboard players operation #kind_off dr_var -= #kind_chain dr_var

# The seeds the track runs through go first, so that the seeds held back for the
#  floors at the end are never among them, where rock may not go
# Each lot draws from a bag of its own, filled for the tier
scoreboard players set #bag_chain dr_var 1
function derailed:dev/gen/_bag_fill
scoreboard players operation #bag_n dr_var = #kind_chain dr_var
function derailed:dev/gen/_bag_share
execute as @e[type=marker,tag=dr_seed,tag=dr_chain,distance=0..] run function derailed:dev/gen/_kind_seed

# The rest draw from a bag first charged for what the seam carried in, so that a
#  section whose western strip arrived as one kind draws that much less of it
scoreboard players set #bag_chain dr_var 0
function derailed:dev/gen/_bag_fill
function derailed:dev/gen/_bag_bleed
scoreboard players operation #bag_n dr_var = #kind_off dr_var
function derailed:dev/gen/_bag_share
execute as @e[type=marker,tag=dr_seed,tag=!dr_chain,distance=0..] run function derailed:dev/gen/_kind_seed
