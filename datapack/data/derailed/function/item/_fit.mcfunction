# Sets '#fit' to how many of the resource #curr_item stack up in '#room'

scoreboard players operation #fit dr_temp = #room dr_temp
execute if score #curr_item dr_arg = $Wood dr_const run return run scoreboard players operation #fit dr_temp /= $WoodLayer dr_const
scoreboard players operation #fit dr_temp /= $ScaledLayer dr_const
