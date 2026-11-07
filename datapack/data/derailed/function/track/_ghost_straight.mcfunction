# Keeps the ghost of the end's rail laid straight on, the way the track came
#  in, '#din', or puts one there, over the end's turned rail, its pieces grown
#  to lie just outside the turned rail's faces: a facing of 0 is south and 90
#  west
# Run at the middle of the end of the track's middle block

execute if entity @e[type=item_display,tag=dr_ghost_straight,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_straight,distance=..0.01] remove dr_ghost_stale

scoreboard players operation #t dr_temp = #din dr_temp
scoreboard players operation #t dr_temp *= $RotationStep dr_const
scoreboard players add #t dr_temp 180
summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_straight"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_ghost_over_curve"}}}
execute store result entity @n[type=item_display,tag=dr_ghost_straight,distance=..0.01] Rotation[0] float 1 run scoreboard players get #t dr_temp
