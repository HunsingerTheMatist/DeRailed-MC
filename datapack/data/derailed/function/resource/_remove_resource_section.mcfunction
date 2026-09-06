
kill @n[type=item_display,distance=..0.1,tag=dr_resource]
setblock ~ ~ ~ air strict
execute positioned ~ ~-0.25 ~ as @n[type=item_display,distance=..0.57,tag=dr_resource_shulker] run function derailed:resource/_remove_skulker
execute positioned ~ ~1.125 ~ run function derailed:resource/update_resource_step
