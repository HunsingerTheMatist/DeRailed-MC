# Find somewhere round the current position to put #curr_item_count of
#  #curr_item, never on it: a pile of the same item first, then any spot
# Run at the centre of the target tile
#
# Args: #curr_item, #curr_item_count
#  #only_same_item and #swap_allowed are set here, not by callers
#
# Returns 1 when any items were placed, fail otherwise

# First we only look for nearby stacks of the same type
scoreboard players set #swap_allowed dr_arg 0
scoreboard players set #only_same_item dr_arg 1
execute positioned ~-1 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~01 if function derailed:item/try_place_here run return 1

# Then we accept any valid position
scoreboard players set #only_same_item dr_arg 0
execute positioned ~-1 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~01 if function derailed:item/try_place_here run return 1
return fail
