
# Builds a rock column's top block
# Positioned at the top block

execute if score #mtopi dr_temp matches 0 run setblock ~ ~ ~ deepslate[axis=x] strict
execute if score #mtopi dr_temp matches 1 run setblock ~ ~ ~ deepslate[axis=z] strict
execute if score #mtopi dr_temp matches -1 run setblock ~ ~ ~ deepslate[axis=y] strict
