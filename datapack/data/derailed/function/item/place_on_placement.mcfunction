# Adds the items to the placement here, or swaps them for it
# Run as the player, at the placement's interaction entity
#
# Returns 1 when any items were placed, fail otherwise

execute if score @n[type=interaction,tag=dr_placement,distance=..0.01] dr_item = #curr_item dr_arg run \
    return run function derailed:item/place_existing
execute if score #swap_allowed dr_arg matches 1 if score @n[type=interaction,tag=dr_placement,distance=..0.01] dr_count <= $HandCap dr_config run \
    return run function derailed:item/swap
return fail
