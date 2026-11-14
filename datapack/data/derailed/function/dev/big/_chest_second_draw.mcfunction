
# Takes a column far enough from the first at random and tags it
#  'dr_big_second' where it fits, and otherwise sets it aside as tried and
#  takes another, until none is left

execute store result score #ch_ok dr_temp run function derailed:dev/big/_chest_draw {pool:"dr_big_pool2",tried:"dr_big_tried2",pick:"dr_big_pick2"}
execute if score #ch_ok dr_temp matches 0 run return 0
execute as @e[type=marker,tag=dr_big_pick2,distance=0..] at @s if function derailed:dev/big/_chest_fit run return run tag @s add dr_big_second
tag @e[type=marker,tag=dr_big_pick2,distance=0..] add dr_big_tried2
tag @e[type=marker,tag=dr_big_pick2,distance=0..] remove dr_big_pick2
return run function derailed:dev/big/_chest_second_draw
