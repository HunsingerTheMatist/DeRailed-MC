# Adds as many of the items still to place as fit to the placement here, where
#  it is of the same item, counting them off '#search_left'
# Run at the placement's interaction entity
#
# Returns 1 once none are left, fail otherwise

execute unless score @n[type=interaction,tag=dr_placement,distance=..0.01] dr_item = #curr_item dr_arg run return fail
execute unless function derailed:item/place_existing run return fail
scoreboard players operation #search_left dr_temp -= #curr_item_count dr_arg
execute if score #search_left dr_temp matches ..0 run return 1
return fail
