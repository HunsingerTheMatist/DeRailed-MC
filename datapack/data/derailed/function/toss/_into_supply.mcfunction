# Puts as much of this thrown pile of wood or iron as the supply wagon it
#  touches, tagged 'dr_toss_touch', has room for into it, where the wagon is of
#  its thrower's team, and holds its thrower off taking it back by auto pickup
# Run as the thrown display

scoreboard players set #thrower dr_temp 0
scoreboard players operation #thrower dr_temp = @s dr_player_id
scoreboard players set #toss_team dr_temp 0
execute as @a if score @s dr_player_id = #thrower dr_temp run scoreboard players operation #toss_team dr_temp = @s dr_team
execute as @e[type=item_display,tag=dr_toss_touch,distance=..5] unless score @s dr_team = #toss_team dr_temp run tag @s remove dr_toss_touch
execute unless entity @e[type=item_display,tag=dr_toss_touch,distance=..5] run return fail

scoreboard players operation #toss_give dr_temp = $SupplyCap dr_config
execute if score #toss_item dr_temp = $Wood dr_const run scoreboard players operation #toss_give dr_temp -= @n[type=item_display,tag=dr_toss_touch,distance=..5] dr_wood
execute if score #toss_item dr_temp = $Iron dr_const run scoreboard players operation #toss_give dr_temp -= @n[type=item_display,tag=dr_toss_touch,distance=..5] dr_iron
scoreboard players operation #toss_give dr_temp < @s dr_count
execute if score #toss_give dr_temp matches ..0 run return fail

execute if score #toss_item dr_temp = $Wood dr_const run scoreboard players operation @n[type=item_display,tag=dr_toss_touch,distance=..5] dr_wood += #toss_give dr_temp
execute if score #toss_item dr_temp = $Iron dr_const run scoreboard players operation @n[type=item_display,tag=dr_toss_touch,distance=..5] dr_iron += #toss_give dr_temp
scoreboard players operation @s dr_count -= #toss_give dr_temp
execute as @n[type=item_display,tag=dr_toss_touch,distance=..5] run function derailed:train/draw_loads

execute if score #toss_item dr_temp = $Wood dr_const as @a if score @s dr_player_id = #thrower dr_temp run tag @s add dr_hold_wood
execute if score #toss_item dr_temp = $Iron dr_const as @a if score @s dr_player_id = #thrower dr_temp run tag @s add dr_hold_iron
