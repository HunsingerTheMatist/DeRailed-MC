# Goes down this column, as far as 3 blocks, to the placement standing in it or
#  the floor under it, and puts the items there; placements tagged 'dr_shift',
#  being moved aside, are passed over
# The block it starts at is only taken for the floor if it is a bottom slab or
#  stairs, which a player or a spawn egg's marker can stand in
# Run as the player, at the bottom middle of a block
#
# Returns 1 when any items were placed, fail otherwise

execute positioned ~ ~0.5 ~ at @n[type=interaction,tag=dr_placement,tag=!dr_shift,distance=..0.5] run \
    return run function derailed:item/place_on_placement
execute if block ~ ~ ~ #minecraft:slabs[type=bottom] if block ~ ~ ~ #derailed:pile_floor run \
    return run function derailed:item/place_on_floor
execute if block ~ ~ ~ #minecraft:stairs[half=bottom] if block ~ ~ ~ #derailed:pile_floor run \
    return run function derailed:item/place_on_floor
execute if score #scan_first dr_temp matches 0 if block ~ ~ ~ #derailed:pile_floor run \
    return run function derailed:item/place_on_floor
execute unless block ~ ~ ~ #derailed:valid_placements run return fail

scoreboard players set #scan_first dr_temp 0
scoreboard players add #scan_cells dr_temp 1
execute if score #scan_cells dr_temp matches 3.. run return fail
execute positioned ~ ~-1 ~ run return run function derailed:item/_scan_column
