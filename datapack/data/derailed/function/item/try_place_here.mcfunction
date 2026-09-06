# Try to put #curr_item_count of #curr_item on this tile
# Run as the player, at the tile
#
# Returns 1 when the items were placed, fail otherwise
#
# The placement's scores are copied out rather than tested with `as`, which would
#  hand the placement's identity to whatever gets called next

# If the position isn't a valid placement no item can be placed there
execute unless block ~ ~ ~ #derailed:valid_placements run \
    return fail

tellraw @a "Valid place"
# If there is no item there then place always succeeds (unless searching for same item type)
execute if score #only_same_item dr_arg matches 0 unless entity @n[type=interaction,distance=..0.5,tag=dr_placement] run \
    return run function derailed:item/place_new

tellraw @a "Item in location"
# If the item there is the same type place always succeeds
execute if score @n[type=interaction,distance=..0.5,tag=dr_placement] dr_item = #curr_item dr_arg run \
    return run function derailed:item/place_existing

tellraw @a "Item of a different type"
# If swapping is allowed and the item has a stack size that can fit in hand, perform a swap
execute if score #swap_allowed dr_arg matches 1 if score @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count <= $HandCap dr_config run \
    return run function derailed:item/swap
