# Writes the main hand to exactly this stack. Macro half of 'fix_items'
# Replaces the main hand outright, so $(stack_size) is the whole new stack
#
# Args: $(item), $(item_model), $(item_name), $(player_id), $(stack_size),
#  $(extra_components), $(jump), $(tool_modifier)
# entity_data sets the owner on the marker this egg spawns
# custom_data records the item type on the item itself
# attribute_modifiers lower the holder's jump strength by $(jump) and their
#  step height to 0.5
# extra_components and tool_modifier are spliced in raw, so each leads with its
#  own comma

$item replace entity @s weapon.mainhand with minecraft:panda_spawn_egg[entity_data={id:"marker",Tags:["dr_item"],data:{owner:$(player_id)}},item_model="$(item_model)",item_name="$(item_name)",custom_data={item:$(item)},attribute_modifiers=[{type:jump_strength,id:"derailed:load_jump",slot:mainhand,amount:$(jump),operation:add_value},{type:step_height,id:"derailed:load_step",slot:mainhand,amount:-0.1,operation:add_value}$(tool_modifier)]$(extra_components)] $(stack_size)
