# Sets '#toss_h' to how tall the box of a thrown pile of #curr_item_count of
#  #curr_item is, the pile they make, in ten-thousandths of a block: a layer
#  each for a resource, a block for the bucket and the tools' flat box

scoreboard players set #toss_h dr_temp 640
execute if score #curr_item dr_arg = $Bucket dr_const run scoreboard players set #toss_h dr_temp 10000
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #toss_h dr_temp = $ScaledLayer dr_const
execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation #toss_h dr_temp = $WoodLayer dr_const
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #toss_h dr_temp *= #curr_item_count dr_arg
