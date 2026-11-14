
# Moves the point the ray lands on half a block further out, and from 1 block out
#  to 20 sends a ray from $(px) 12/16 $(pz) across the chest's block to a
#  player's eyes there, where a player could stand there ('_chest_ground',
#  '_chest_ray'), until one reaches them
# Positioned at the chest's top block

scoreboard players add #ch_L dr_temp 1
execute if score #ch_L dr_temp matches 41.. run return 0
execute as @n[type=marker,tag=dr_chest_walker,distance=..64] at @s run tp @s ^ ^ ^0.5
scoreboard players set #ch_g dr_temp 0
execute if score #ch_L dr_temp matches 2.. at @n[type=marker,tag=dr_chest_walker,distance=..64] if function derailed:dev/big/_chest_ground run scoreboard players set #ch_g dr_temp 1
scoreboard players set #ch_rs dr_temp 0
$execute if score #ch_g dr_temp matches 1 positioned ~$(px) ~0.75 ~$(pz) facing entity @n[type=marker,tag=dr_chest_walker,distance=..64] feet run function derailed:dev/big/_chest_ray
execute if score #ch_seen dr_temp matches 1 run return 1
$function derailed:dev/big/_chest_land {px:$(px),pz:$(pz)}
