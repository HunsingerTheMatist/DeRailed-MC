# Try to put #curr_resource_count of #curr_resource on this tile
# Run as the player, at the tile
#
# Returns 1 when the resources were placed, fail otherwise
#
# The pile's scores are copied out rather than tested with `as`, which would
#  hand the pile's identity to whatever gets called next

# If the position isn't a valid placement no resource can be placed there
execute unless block ~ ~ ~ #derailed:valid_placements run \
    return fail

tellraw @a "Valid place"
# If there is no resource there then place always succeeds (unless searching for same resource type)
execute if score #only_same_resource dr_arg matches 0 unless entity @n[type=interaction,distance=..0.5,tag=dr_resource] run \
    return run function derailed:item/place_new

tellraw @a "Resource in location"
# If the resource there is the same type place always succeeds
execute if score @n[type=interaction,distance=..0.5,tag=dr_resource] dr_resource = #curr_resource dr_arg run \
    return run function derailed:item/place_existing

tellraw @a "Resource different type"
# If swapping is allowed and the resource has a stack size that can fit in hand, perform a swap
execute if score #swap_allowed dr_arg matches 1 if score @n[type=interaction,distance=..0.5,tag=dr_resource] dr_count <= $HandCap dr_config run \
    return run function derailed:item/swap
