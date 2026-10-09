
# Adds this player's arrow: across and down to the half map pixel where they
#  stand on the large version, kept to the board, turned to the nearest of
#  sixteen ways they face, in the colour they were given when first seen
# Run as the player

execute unless score @s dr_hud_col matches 0.. store result score @s dr_hud_col run scoreboard players add #hud_next dr_var 1

execute store result score #hx dr_temp run data get entity @s Pos[0] 1000
scoreboard players remove #hx dr_temp 1100000
scoreboard players operation #hx dr_temp /= $HudPixel dr_const
execute if score #hx dr_temp matches ..-1 run scoreboard players set #hx dr_temp 0
execute if score #hx dr_temp >= $HudBoardWidth dr_const run scoreboard players operation #hx dr_temp = $HudBoardWidth dr_const
execute if score #hx dr_temp = $HudBoardWidth dr_const run scoreboard players remove #hx dr_temp 1

execute store result score #hz dr_temp run data get entity @s Pos[2] 1000
scoreboard players operation #hz dr_temp /= $HudPixel dr_const
execute if score #hz dr_temp matches ..-1 run scoreboard players set #hz dr_temp 0
execute if score #hz dr_temp >= $HudBoardHeight dr_const run scoreboard players operation #hz dr_temp = $HudBoardHeight dr_const
execute if score #hz dr_temp = $HudBoardHeight dr_const run scoreboard players remove #hz dr_temp 1

# Facing south is a yaw of 0 and the arrow's way 8, down the board; half a
#  step over rounds to the nearest
execute store result score #ha dr_temp run data get entity @s Rotation[0] 1000
scoreboard players add #ha dr_temp 191250
scoreboard players operation #ha dr_temp /= $HudTurnStep dr_const
scoreboard players operation #ha dr_temp %= $Sixteen dr_const
execute if score #ha dr_temp matches ..-1 run scoreboard players add #ha dr_temp 16

scoreboard players operation #hz dr_temp *= $Sixteen dr_const
execute store result storage derailed:hud m.x int 1 run scoreboard players get #hx dr_temp
execute store result storage derailed:hud m.c int 1 run scoreboard players operation #hz dr_temp += #ha dr_temp
scoreboard players operation #hn dr_temp = @s dr_hud_col
execute store result storage derailed:hud m.n int 1 run scoreboard players operation #hn dr_temp %= $Six dr_const
function derailed:dev/hud/_marker_add with storage derailed:hud m
