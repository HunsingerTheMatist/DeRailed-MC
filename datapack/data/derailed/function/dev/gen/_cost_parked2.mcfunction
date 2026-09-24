
# Sets up a marker just parked on a rock tile for the second route: it wakes on
#  the same level, '#gen_second_rock' waves on from the one that reached it
# Run as the marker

tag @s add dr_flood
tag @s add dr_rock_wait
scoreboard players operation @s dr_wave = #cost_wave dr_var
scoreboard players operation @s dr_wave += #gen_second_rock dr_var
scoreboard players operation @s dr_level = #cost_level dr_var

# The tile the track leaves on may be rock itself, and then stepping onto it is
#  the route done
execute if block ~ ~2 ~ gold_block run tag @s add dr_goal
