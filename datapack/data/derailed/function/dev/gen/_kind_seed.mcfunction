
# Gives this seed its kind: drawn from the bag while there are more seeds left
#  than the floors are owed, and taken from what is owed once there are not, so
#  that every floor is met without any seed being changed afterwards
# Run as the seed

# A region the river ran out against is water whatever else would have come up,
#  so a reroll cannot leave the river ending on dry ground; it comes out of the
#  bag like any other draw of water
execute if entity @s[tag=dr_lake] run scoreboard players set #gen_kind dr_var 3
execute if entity @s[tag=dr_lake] run scoreboard players operation #bag_take dr_var = #bag_share dr_var
execute if entity @s[tag=dr_lake] run function derailed:dev/gen/_bag_shift
execute if entity @s[tag=dr_lake] run return run function derailed:dev/gen/_kind_take

execute if score #kind_owed dr_var >= #kind_left dr_var run function derailed:dev/gen/_kind_owed
execute if score #kind_owed dr_var < #kind_left dr_var run function derailed:dev/gen/_kind_draw
function derailed:dev/gen/_kind_take
