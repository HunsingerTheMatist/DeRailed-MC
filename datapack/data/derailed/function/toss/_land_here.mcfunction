# Puts the thrown pile's items down from here, through the search for a spot
#  from the block here, and whatever finds nowhere as a pile right here,
#  whatever stands there
# The display places them, since placing takes the items off whoever runs it
# Run as the thrown display, with #curr_item, #curr_item_count and
#  #curr_rotation its own

execute align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/place_near
execute if score #search_left dr_temp matches 1.. run scoreboard players operation #curr_item_count dr_arg = #search_left dr_temp
execute if score #search_left dr_temp matches 1.. run function derailed:item/place_new
