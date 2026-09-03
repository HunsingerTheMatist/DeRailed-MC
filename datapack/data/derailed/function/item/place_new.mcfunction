# Start a new pile on this tile holding #curr_resource_count of #curr_resource
# Run as the player, at the tile

tellraw @a "Placing new stack"
summon interaction ~ ~ ~ {width:0.7, height:0.5, response:true, Tags:["dr_resource"]}
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_resource] dr_resource = #curr_resource dr_arg
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_resource] dr_count = #curr_resource_count dr_arg

# Pile starts facing the direction of the player, snapped to 90 degree steps
# Biasing by 45 rounds to the nearest step; the extra 360 keeps the divide
#  positive, so negative yaw snaps the same way as positive
execute store result score #rotation dr_temp run data get entity @s Rotation[0] 1
scoreboard players add #rotation dr_temp 405
scoreboard players operation #rotation dr_temp /= $RotationStep dr_const
scoreboard players operation #rotation dr_temp *= $RotationStep dr_const
execute store result entity @n[type=interaction,distance=..0.5,tag=dr_resource] Rotation[0] float 1 run scoreboard players remove #rotation dr_temp 360

execute as @n[type=interaction,distance=..0.5,tag=dr_resource] at @s run function derailed:resource/update_resource

function derailed:player/take_resources
return 1
