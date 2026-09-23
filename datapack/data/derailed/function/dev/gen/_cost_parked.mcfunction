
# Sets up a marker just parked on a rock tile
# Run as the marker

tag @s add dr_flood
tag @s add dr_rock_wait
scoreboard players operation @s dr_wave = #cost_wave dr_var
scoreboard players operation @s dr_level = #cost_level dr_var
scoreboard players add @s dr_level 1

# The tile the track leaves on may be rock itself, and then stepping onto it is
#  the route done
execute if block ~ ~2 ~ gold_block run tag @s add dr_goal
