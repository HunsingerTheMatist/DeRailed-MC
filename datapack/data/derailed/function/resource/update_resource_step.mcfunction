# Run as the pile's interaction entity
#
# Args:
# #resources_to_place - the resources left to place in this pile

execute store result score #item_display_here dr_temp if entity @n[type=item_display,distance=..0.1,tag=dr_resource]

# If there's no resources left and no item display here, stop
execute if score #resources_to_place dr_arg matches ..0 if score #item_display_here dr_temp matches 0 run \
    return 1

# If there's no resources left, kill the item display and continue up the chain
execute if score #resources_to_place dr_arg matches ..0 run \
    return run function derailed:resource/_remove_resource_section

# Since there are resources left, if there is no item display here, create it
execute if score #item_display_here dr_temp matches 0 run function derailed:resource/_add_item_display

function derailed:resource/_update_resource_section

scoreboard players operation #resources_to_place dr_arg -= $ResourceBatchHeight dr_const
execute positioned ~ ~1.125 ~ run function derailed:resource/update_resource_step
