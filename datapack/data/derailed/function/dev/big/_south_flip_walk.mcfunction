
# Has the tile of the stretch this one flowed into flow back into it instead,
#  then does the same from there
# Positioned at a tile of the stretch already turned

tag @n[type=marker,tag=dr_big_seg,distance=..0.5] add dr_big_flip
scoreboard players set #s_d dr_temp -1
execute as @n[type=marker,tag=dr_big_seg,distance=..0.5] run scoreboard players operation #s_d dr_temp = @s dr_bdir
scoreboard players operation #s_n dr_temp = #s_d dr_temp
scoreboard players add #s_n dr_temp 2
scoreboard players operation #s_n dr_temp %= $Four dr_const
execute if score #s_d dr_temp matches 0 positioned ~ ~ ~-3 as @e[type=marker,tag=dr_big_seg,tag=!dr_big_flip,distance=..0.5] at @s run return run function derailed:dev/big/_south_flip_next
execute if score #s_d dr_temp matches 1 positioned ~3 ~ ~ as @e[type=marker,tag=dr_big_seg,tag=!dr_big_flip,distance=..0.5] at @s run return run function derailed:dev/big/_south_flip_next
execute if score #s_d dr_temp matches 2 positioned ~ ~ ~3 as @e[type=marker,tag=dr_big_seg,tag=!dr_big_flip,distance=..0.5] at @s run return run function derailed:dev/big/_south_flip_next
execute if score #s_d dr_temp matches 3 positioned ~-3 ~ ~ as @e[type=marker,tag=dr_big_seg,tag=!dr_big_flip,distance=..0.5] at @s run function derailed:dev/big/_south_flip_next
