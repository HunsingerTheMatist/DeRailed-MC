
# Takes one of the columns tagged $(pool) and not $(tried) at random, each as
#  likely as its tile is deep, and tags it $(pick), going through them in order
#  of how near they stand to a point no two can be equally near; fails where
#  none is left

scoreboard players set #ch_t dr_temp 0
$execute as @e[type=marker,tag=$(pool),tag=!$(tried),distance=0..] run scoreboard players operation #ch_t dr_temp += @s dr_bd
execute if score #ch_t dr_temp matches ..0 run return 0
function derailed:dev/big/_chest_rand
$data modify storage derailed:big chest.pick set value "$(pick)"
$execute positioned 1099.37 0.0 -0.71 as @e[type=marker,tag=$(pool),tag=!$(tried),distance=0..,sort=nearest] run function derailed:dev/big/_chest_walk with storage derailed:big chest
return 1
