# Puts as many of the '#search_left' items still to place as it can in this
#  block, where it stands on a floor, the block under it or this block itself
#  where it is a bottom slab or stairs: onto the placement standing in it,
#  where it is of the same item and no other placement takes it, or else onto
#  that floor
# Placements are only looked for where 'item/place_near' found any within reach
# Run at the bottom middle of the block
#
# Returns 1 once none are left, fail otherwise

execute unless block ~ ~ ~ #derailed:valid_placements unless block ~ ~ ~ #minecraft:slabs[type=bottom] unless block ~ ~ ~ #minecraft:stairs[half=bottom] run return fail

# The floor: 1 this block, 2 the block under it
scoreboard players set #spot_floor dr_temp 0
execute if block ~ ~ ~ #minecraft:slabs[type=bottom] if block ~ ~ ~ #derailed:pile_floor run scoreboard players set #spot_floor dr_temp 1
execute if block ~ ~ ~ #minecraft:stairs[half=bottom] if block ~ ~ ~ #derailed:pile_floor run scoreboard players set #spot_floor dr_temp 1
execute if score #spot_floor dr_temp matches 0 if block ~ ~ ~ #derailed:valid_placements if block ~ ~-1 ~ #derailed:pile_floor run scoreboard players set #spot_floor dr_temp 2
execute if score #spot_floor dr_temp matches 0 run return fail

# The pile search benches time the lines and the block tests alone, every spot
#  refused
execute if score #bench_search dr_var matches 1 run return fail

scoreboard players operation #curr_item_count dr_arg = #search_left dr_temp
execute if score #piles_near dr_temp matches 1 positioned ~-0.5 ~ ~-0.5 at @n[type=interaction,tag=dr_placement,tag=!dr_shift,dx=0,dy=0,dz=0] run \
    return run function derailed:item/_merge_spot
execute if score #spot_floor dr_temp matches 1 run return run function derailed:item/_floor_spot
execute positioned ~ ~-1 ~ run return run function derailed:item/_floor_spot
