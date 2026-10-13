
# TODO: Change interaction size and add item displays based on stack size
# Maybe have the block displays (or whatever entity we use) ride the interaction

# A resource's interaction is as tall as its pile and a pixel and a
#  ten-thousandth over, in ten-thousandths of a block: wood is 9 pixels a
#  layer, and iron and rails, drawn twice their size, 12
scoreboard players operation #stack_height dr_temp = $ScaledLayer dr_const
execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation #stack_height dr_temp = $WoodLayer dr_const
scoreboard players operation #stack_height dr_temp *= @s dr_count
execute if score #curr_item dr_arg <= $LastResource dr_const store result entity @s height float 0.0001 run scoreboard players add #stack_height dr_temp 626

scoreboard players operation #items_to_place dr_arg = @s dr_count

tellraw @a [{score:{objective:"dr_arg",name:"#items_to_place"}}]
execute positioned ~ ~0.5 ~ run function derailed:placement/update_placement_step
function derailed:placement/_set_collision

# Remove empty placements
execute if score @s dr_count matches 1.. run return 1
kill @s
