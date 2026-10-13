
kill @n[type=item_display,distance=..0.1,tag=dr_placement]
execute if score #curr_item dr_arg = $Wood dr_const positioned ~ ~1.6875 ~ run return run function derailed:placement/update_placement_step
execute positioned ~ ~2.25 ~ run function derailed:placement/update_placement_step
