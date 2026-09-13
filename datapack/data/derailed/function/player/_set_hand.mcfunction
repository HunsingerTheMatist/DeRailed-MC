# Writes the main hand to exactly this stack. Macro half of 'fix_items'
# Replaces the main hand outright, so $(stack_size) is the whole new stack
#
# Args: $(item), $(item_model), $(item_name), $(player_id), $(stack_size),
#  $(extra_components)
# entity_data sets the owner on the marker this egg spawns
# custom_data records the item type on the item itself
# extra_components is spliced in raw, so it leads with its own comma

$item replace entity @s weapon.mainhand with minecraft:panda_spawn_egg[entity_data={id:"marker",Tags:["dr_item"],data:{owner:$(player_id)}},item_model="$(item_model)",item_name="$(item_name)",custom_data={item:$(item)}$(extra_components)] $(stack_size)
