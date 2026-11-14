
# Takes a column of the pool at random as the first chest's and puts both chests
#  where it fits and a second is found for it ('_chest_second'), and otherwise
#  sets it aside as tried and takes another, until none is left

execute store result score #ch_ok dr_temp run function derailed:dev/big/_chest_draw {pool:"dr_big_pool",tried:"dr_big_tried",pick:"dr_big_pick"}
execute if score #ch_ok dr_temp matches 0 run return 0
execute as @e[type=marker,tag=dr_big_pick,distance=0..] at @s if function derailed:dev/big/_chest_fit if function derailed:dev/big/_chest_second run return run function derailed:dev/big/_chest_place_both
tag @e[type=marker,tag=dr_big_pick,distance=0..] add dr_big_tried
tag @e[type=marker,tag=dr_big_pick,distance=0..] remove dr_big_pick
return run function derailed:dev/big/_chest_pair_draw
