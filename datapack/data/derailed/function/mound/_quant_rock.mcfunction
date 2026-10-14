
# Tops a rock column nearest the '#mH' pixels left over its '#mk' whole
#  blocks: 8 a slab, 16 one whole block more

execute if score #mH dr_temp matches 4..11 run scoreboard players set #mcap dr_temp 0
execute if score #mH dr_temp matches 12..15 run scoreboard players add #mk dr_temp 1
