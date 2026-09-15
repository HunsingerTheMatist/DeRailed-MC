
scoreboard players operation #item dr_temp = @s dr_item
tag @e[type=interaction,distance=..10,tag=dr_placement] remove dr_current
execute as @e[type=interaction,distance=..1,tag=dr_placement] if score @s dr_item = #item dr_temp run \
    return run tag @s add dr_current
