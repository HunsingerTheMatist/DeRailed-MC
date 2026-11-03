# Goes on along the aim a twentieth of a block at a time, as far as 6 blocks,
#  to the first point inside the supply wagon's interaction that was clicked,
#  and takes into '#curr_item' the item of the wagon's pile nearest that point,
#  wood over its front half and iron over its back
# Run at a point on the aim, facing along it

execute positioned ~-0.995 ~-0.995 ~-0.995 as @e[type=interaction,tag=dr_train_click,tag=dr_current,dx=0,dy=0,dz=0] positioned ~0.99 ~0.99 ~0.99 if entity @s[dx=0,dy=0,dz=0] run \
    return run scoreboard players operation #curr_item dr_arg = @n[type=item_display,tag=dr_supply_load,distance=..4] dr_item

scoreboard players add #ray_steps dr_temp 1
execute if score #ray_steps dr_temp matches 120.. run return 0
execute positioned ^ ^ ^0.05 run return run function derailed:train/_supply_aim
