# Keeps the ghost of the end's rail turned from the way the track came in to
#  the way on, '#d', or puts one there, over the end's straight rail
# Run at the middle of the end of the track's middle block, with the way the
#  track came in by in '#din'

# The edge it comes in by, which the ghost leaves its straight run off: the
#  end's straight rail already lies there
scoreboard players operation #a dr_temp = #din dr_temp
scoreboard players add #a dr_temp 2
scoreboard players operation #a dr_temp %= $Four dr_const

# Which turn it is, as the edge it comes in by and the edge it leaves by: each
#  is one of the two ghost models, the one leaving out the run in from the
#  south or from the east, turned so that run is the one it comes in by
scoreboard players set #turn dr_temp -1
execute if score #a dr_temp matches 2 if score #d dr_temp matches 1 run scoreboard players set #turn dr_temp 21
execute if score #a dr_temp matches 3 if score #d dr_temp matches 2 run scoreboard players set #turn dr_temp 32
execute if score #a dr_temp matches 0 if score #d dr_temp matches 3 run scoreboard players set #turn dr_temp 3
execute if score #a dr_temp matches 1 if score #d dr_temp matches 0 run scoreboard players set #turn dr_temp 10
execute if score #a dr_temp matches 1 if score #d dr_temp matches 2 run scoreboard players set #turn dr_temp 12
execute if score #a dr_temp matches 2 if score #d dr_temp matches 3 run scoreboard players set #turn dr_temp 23
execute if score #a dr_temp matches 3 if score #d dr_temp matches 0 run scoreboard players set #turn dr_temp 30
execute if score #a dr_temp matches 0 if score #d dr_temp matches 1 run scoreboard players set #turn dr_temp 1
execute if score #turn dr_temp matches -1 run return 0

execute if score #turn dr_temp matches 21 if entity @e[type=item_display,tag=dr_ghost_turn_21,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_21,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 32 if entity @e[type=item_display,tag=dr_ghost_turn_32,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_32,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 3 if entity @e[type=item_display,tag=dr_ghost_turn_03,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_03,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 10 if entity @e[type=item_display,tag=dr_ghost_turn_10,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_10,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 12 if entity @e[type=item_display,tag=dr_ghost_turn_12,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_12,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 23 if entity @e[type=item_display,tag=dr_ghost_turn_23,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_23,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 30 if entity @e[type=item_display,tag=dr_ghost_turn_30,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_30,distance=..0.01] remove dr_ghost_stale
execute if score #turn dr_temp matches 1 if entity @e[type=item_display,tag=dr_ghost_turn_01,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_ghost_turn_01,distance=..0.01] remove dr_ghost_stale

# The models run in from the south or east and turn to the east or south, as
#  the curved rail's blockstate does unturned; an item display turns its model
#  half a turn more than its facing, so each faces half a turn round from the
#  quarter turns that bring the edge it comes in by round to the model's
execute if score #turn dr_temp matches 21 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_21"],Rotation:[180f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_south"}}}
execute if score #turn dr_temp matches 32 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_32"],Rotation:[270f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_south"}}}
execute if score #turn dr_temp matches 3 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_03"],Rotation:[0f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_south"}}}
execute if score #turn dr_temp matches 10 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_10"],Rotation:[90f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_south"}}}
execute if score #turn dr_temp matches 12 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_12"],Rotation:[180f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_east"}}}
execute if score #turn dr_temp matches 23 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_23"],Rotation:[270f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_east"}}}
execute if score #turn dr_temp matches 30 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_30"],Rotation:[0f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_east"}}}
execute if score #turn dr_temp matches 1 run \
    summon item_display ~ ~ ~ {Tags:["dr_rail_ghost","dr_ghost_turn_01"],Rotation:[90f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_curved_ghost_from_east"}}}
