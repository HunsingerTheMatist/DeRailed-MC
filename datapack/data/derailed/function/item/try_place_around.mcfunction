# Find somewhere round the current position to put #curr_item_count of
#  #curr_item, never on it: the spots a block away first, a pile of the same
#  item and then any spot, then those two blocks away the same way, nearest
#  first, which always reaches past the tile the position is on
# Run at the centre of the target tile
#
# Args: #curr_item, #curr_item_count
#  #only_same_item and #swap_allowed are set here, not by callers
#
# Returns 1 when any items were placed, fail otherwise

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

scoreboard players set #only_same_item dr_arg 0
execute positioned ~-1 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~01 if function derailed:item/try_place_here run return 1

scoreboard players set #only_same_item dr_arg 1
execute positioned ~-2 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~02 if function derailed:item/try_place_here run return 1

scoreboard players set #only_same_item dr_arg 0
execute positioned ~-2 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~00 if function derailed:item/try_place_here run return 1
execute positioned ~00 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~-1 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~01 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-1 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~01 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~-2 if function derailed:item/try_place_here run return 1
execute positioned ~02 ~ ~02 if function derailed:item/try_place_here run return 1
execute positioned ~-2 ~ ~02 if function derailed:item/try_place_here run return 1
return fail
