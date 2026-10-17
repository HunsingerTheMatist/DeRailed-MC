# Adds as many of this thrown pile's items as fit to the pile here, which takes
#  them off the thrown pile's own count
# Run as the thrown display, at the pile's interaction entity

execute if score @s dr_count matches ..0 run return 0
scoreboard players operation #curr_item_count dr_arg = @s dr_count
function derailed:item/place_existing
