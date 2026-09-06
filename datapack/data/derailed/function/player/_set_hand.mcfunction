# Writes the main hand to exactly this stack. Macro half of 'fix_items'
# Replaces the main hand outright, so $(stack_size) is the whole new stack
#
# Args: $(item), $(item_name), $(player_id), $(stack_size)
# entity_data sets the owner on the marker this egg spawns
# custom_data records the item type on the item itself

$item replace entity @s weapon.mainhand with minecraft:panda_spawn_egg[entity_data={id:"marker",Tags:["dr_item"],data:{owner:$(player_id)}},custom_data={item:$(item)},custom_model_data={strings:[$(custom_model_data)]},item_model="derailed:$(item_name)"] $(stack_size)
