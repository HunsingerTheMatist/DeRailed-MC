
kill @n[type=item_display,distance=..0.1,tag=dr_placement]
setblock ~ ~ ~ air strict
execute positioned ~ ~-0.25 ~ as @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] run function derailed:placement/_remove_shulker
execute positioned ~ ~1.125 ~ run function derailed:placement/update_placement_step
