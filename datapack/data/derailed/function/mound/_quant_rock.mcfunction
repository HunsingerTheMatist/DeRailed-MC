
# Tops a rock column nearest the '#mH' pixels left over its '#mk' whole
#  blocks: 6 and 12 a tall top block, 16 one whole block more

execute if score #mH dr_temp matches 3..8 run scoreboard players set #mtopi dr_temp 0
execute if score #mH dr_temp matches 9..13 run scoreboard players set #mtopi dr_temp 1
execute if score #mH dr_temp matches 14..15 run scoreboard players add #mk dr_temp 1
