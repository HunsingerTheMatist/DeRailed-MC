
# Tops a rock column nearest the '#mH' pixels left over its '#mk' whole
#  blocks: 6 and 12 a tall top block, 16 one whole block more

execute if score #mH dr_var matches 3..8 run scoreboard players set #mtopi dr_var 0
execute if score #mH dr_var matches 9..13 run scoreboard players set #mtopi dr_var 1
execute if score #mH dr_var matches 14..15 run scoreboard players add #mk dr_var 1
