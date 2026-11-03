# Puts as much of this thrown pile of wood or iron as the supply wagon has room
#  for into it, and holds its thrower off taking it back by auto pickup
# Run as the thrown display

scoreboard players operation #toss_give dr_temp = $SupplyCap dr_config
execute if score #toss_item dr_temp = $Wood dr_const run scoreboard players operation #toss_give dr_temp -= $SupplyWood dr_var
execute if score #toss_item dr_temp = $Iron dr_const run scoreboard players operation #toss_give dr_temp -= $SupplyIron dr_var
scoreboard players operation #toss_give dr_temp < @s dr_count
execute if score #toss_give dr_temp matches ..0 run return fail

execute if score #toss_item dr_temp = $Wood dr_const run scoreboard players operation $SupplyWood dr_var += #toss_give dr_temp
execute if score #toss_item dr_temp = $Iron dr_const run scoreboard players operation $SupplyIron dr_var += #toss_give dr_temp
scoreboard players operation @s dr_count -= #toss_give dr_temp
function derailed:train/draw_loads

scoreboard players operation #thrower dr_temp = @s dr_player_id
execute if score #toss_item dr_temp = $Wood dr_const as @a if score @s dr_player_id = #thrower dr_temp run tag @s add dr_hold_wood
execute if score #toss_item dr_temp = $Iron dr_const as @a if score @s dr_player_id = #thrower dr_temp run tag @s add dr_hold_iron
