
# Tops an iron column nearest the '#mH' pixels left over its '#mk' whole
#  blocks: 4 the tall top block, 8 and 12 a slab, 16 one whole block more

execute if score #mH dr_temp matches 2..5 run scoreboard players set #mtopi dr_temp 0
execute if score #mH dr_temp matches 6..9 run scoreboard players set #mcap dr_temp 0
execute if score #mH dr_temp matches 10..13 run scoreboard players set #mcap dr_temp 1
execute if score #mH dr_temp matches 14..15 run scoreboard players add #mk dr_temp 1
