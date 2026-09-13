
setblock ~ ~ ~ oak_slab[type=top] strict
#setblock ~ ~2 ~ air
#data modify entity @n[type=interaction,distance=..1,tag=dr_water,tag=dr_current] height set value 1.1
#kill @n[type=interaction,distance=..1,tag=dr_water,tag=dr_current]
playsound block.scaffolding.place block @s

function derailed:player/take_items
