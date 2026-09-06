# Find somewhere to put #curr_item_count of #curr_item, starting at the current
# position and spiralling outward
# Run as the player, at the centre of the target tile
#
# Args: #curr_item, #curr_player_id, #curr_item_count, #swap_allowed
#  The caller has already taken the items off the player, so a refusal ends
#  in 'place_fail' handing them back
#  #only_same_item is set here, not by callers

# First we try to place in the current location
scoreboard players set #only_same_item dr_arg 0
execute if function derailed:item/try_place_here run return 1

tellraw @a "Failed primary location"
# Current location isn't valid. Search around for a valid location
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

# If nothing is available, the place fails
function derailed:item/place_fail
return fail
