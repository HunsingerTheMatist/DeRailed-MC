
# Tops an iron column nearest the '#mH' pixels left over its '#mk' whole
#  blocks: 4 the tall top block, 8 and 12 a slab, 16 one whole block more

execute if score #mH dr_var matches 2..5 run scoreboard players set #mtopi dr_var 0
execute if score #mH dr_var matches 6..9 run scoreboard players set #mcap dr_var 0
execute if score #mH dr_var matches 10..13 run scoreboard players set #mcap dr_var 1
execute if score #mH dr_var matches 14..15 run scoreboard players add #mk dr_var 1
