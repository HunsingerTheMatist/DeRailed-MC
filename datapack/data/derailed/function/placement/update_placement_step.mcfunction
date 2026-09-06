# Run as the placement's interaction entity
#
# Args:
# #items_to_place - the items left to place in this placement

execute store result score #item_display_here dr_temp if entity @n[type=item_display,distance=..0.1,tag=dr_placement]

# If there's no items left and no item display here, stop
execute if score #items_to_place dr_arg matches ..0 if score #item_display_here dr_temp matches 0 run \
    return 1

# If there's no items left, kill the item display and continue up the chain
execute if score #items_to_place dr_arg matches ..0 run \
    return run function derailed:placement/_remove_placement_section

# Since there are items left, if there is no item display here, create it
execute if score #item_display_here dr_temp matches 0 run function derailed:placement/_add_item_display

function derailed:placement/_update_placement_section

scoreboard players operation #items_to_place dr_arg -= $BatchHeight dr_const
execute positioned ~ ~1.125 ~ run function derailed:placement/update_placement_step
