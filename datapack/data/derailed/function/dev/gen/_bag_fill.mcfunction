
# Fills the bag for the tier, and for whether the seeds about to draw from it
#  are the ones the track runs through, which '#bag_chain' says
# The weights are kept a second time as they were filled, since that is the
#  ratio what a draw takes is handed out by, whatever the bag has come to

execute if score #gen_difficulty dr_var matches 0 if score #bag_chain dr_var matches 1 run function derailed:dev/gen/_bag_easy_chain
execute if score #gen_difficulty dr_var matches 0 unless score #bag_chain dr_var matches 1 run function derailed:dev/gen/_bag_easy_off
execute if score #gen_difficulty dr_var matches 2 if score #bag_chain dr_var matches 1 run function derailed:dev/gen/_bag_hard_chain
execute if score #gen_difficulty dr_var matches 2 unless score #bag_chain dr_var matches 1 run function derailed:dev/gen/_bag_hard_off
execute unless score #gen_difficulty dr_var matches 0 unless score #gen_difficulty dr_var matches 2 if score #bag_chain dr_var matches 1 run function derailed:dev/gen/_bag_medium_chain
execute unless score #gen_difficulty dr_var matches 0 unless score #gen_difficulty dr_var matches 2 unless score #bag_chain dr_var matches 1 run function derailed:dev/gen/_bag_medium_off

scoreboard players operation #base_ground dr_var = #bag_ground dr_var
scoreboard players operation #base_wood dr_var = #bag_wood dr_var
scoreboard players operation #base_iron dr_var = #bag_iron dr_var
scoreboard players operation #base_water dr_var = #bag_water dr_var
scoreboard players operation #base_rock dr_var = #bag_rock dr_var
