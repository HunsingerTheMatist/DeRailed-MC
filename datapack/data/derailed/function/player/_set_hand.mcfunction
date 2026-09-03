# Writes the main hand to exactly this stack. Macro half of 'fix_resources'
# Replaces the main hand outright, so $(stack_size) is the whole new stack
#
# Args: $(resource), $(resource_name), $(player_id), $(stack_size)
# entity_data sets the owner on the marker this egg spawns
# custom_data records the resource type on the item itself

$item replace entity @s weapon.mainhand with minecraft:panda_spawn_egg[entity_data={id:"marker",Tags:["dr_resource"],data:{owner:$(player_id)}},custom_data={resource:$(resource)},item_model="derailed:resource/$(resource_name)"] $(stack_size)
