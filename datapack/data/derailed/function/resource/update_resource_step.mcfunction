# Run as the pile's interaction entity
#
# Args:
# #resources_to_place - the resources left to place in this pile

execute store result score #item_display_here dr_temp if entity @n[type=item_display,distance=..0.1,tag=dr_resource]

# If there's no resources left and no item display here, stop
execute if score #resources_to_place dr_arg matches ..0 if score #item_display_here dr_temp matches 0 run \
    return 1

# If there's no resources left, kill the item display and continue up the chain
execute if score #resources_to_place dr_arg matches ..0 run kill @n[type=item_display,distance=..0.1,tag=dr_resource]
execute if score #resources_to_place dr_arg matches ..0 positioned ~ ~1.35 ~ run return run function derailed:resource/update_resource_step

# If the resources left are less than the resources in the item display, kill it to refresh
#scoreboard players reset #previous_count dr_temp
#execute if score #resources_to_place dr_arg < $ResourceBatchHeight dr_const store result score #previous_count dr_temp run data get entity @n[type=item_display,distance=..0.1,tag=dr_resource] item.count 1
#execute if score #resources_to_place dr_arg < #previous_count dr_temp run kill @n[type=item_display,distance=..0.1,tag=dr_resource]
#execute if score #resources_to_place dr_arg < #previous_count dr_temp run scoreboard players set #item_display_here dr_temp 0

# Since there are resources left, if there is no item display here, create it
execute if score #item_display_here dr_temp matches 0 run function derailed:resource/_summon_item_display

# The model dispatches on stack count, so setting the count picks the model
scoreboard players operation #display_count dr_temp = #resources_to_place dr_arg
execute store result entity @n[type=item_display,distance=..0.1,tag=dr_resource] item.count int 1 run scoreboard players operation #display_count dr_temp < $ResourceBatchHeight dr_const

scoreboard players operation #resources_to_place dr_arg -= $ResourceBatchHeight dr_const
execute positioned ~ ~1.35 ~ run function derailed:resource/update_resource_step
