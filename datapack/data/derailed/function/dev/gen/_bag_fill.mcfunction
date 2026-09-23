
# Fills the bag for the tier
# The weights are kept a second time as they were filled, since that is the
#  ratio what a draw takes is handed out by, whatever the bag has come to

execute if score #gen_difficulty dr_var matches 0 run function derailed:dev/gen/_bag_easy
execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/_bag_hard
execute unless score #gen_difficulty dr_var matches 0 unless score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/_bag_medium

scoreboard players operation #base_ground dr_var = #bag_ground dr_var
scoreboard players operation #base_wood dr_var = #bag_wood dr_var
scoreboard players operation #base_iron dr_var = #bag_iron dr_var
scoreboard players operation #base_water dr_var = #bag_water dr_var
scoreboard players operation #base_rock dr_var = #bag_rock dr_var
