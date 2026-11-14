
# Takes a column of the pool at random and puts the chest on it where it fits,
#  and otherwise sets it aside as tried and takes another, until none is left

execute store result score #ch_ok dr_temp run function derailed:dev/big/_chest_draw {pool:"dr_big_pool",tried:"dr_big_tried",pick:"dr_big_pick"}
execute if score #ch_ok dr_temp matches 0 run return 0
execute as @e[type=marker,tag=dr_big_pick,distance=0..] at @s if function derailed:dev/big/_chest_fit run return run function derailed:dev/big/_chest_place
tag @e[type=marker,tag=dr_big_pick,distance=0..] add dr_big_tried
tag @e[type=marker,tag=dr_big_pick,distance=0..] remove dr_big_pick
return run function derailed:dev/big/_chest_one_draw
