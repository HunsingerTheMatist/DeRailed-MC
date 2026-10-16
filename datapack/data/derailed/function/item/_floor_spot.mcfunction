# Starts a placement on the floor block here with as many of the items still to
#  place as fit, counting them off '#search_left'
# Run at the bottom middle of the floor block
#
# Returns 1 once none are left, fail otherwise

execute unless function derailed:item/place_on_floor run return fail
scoreboard players operation #search_left dr_temp -= #curr_item_count dr_arg
execute if score #search_left dr_temp matches ..0 run return 1
return fail
