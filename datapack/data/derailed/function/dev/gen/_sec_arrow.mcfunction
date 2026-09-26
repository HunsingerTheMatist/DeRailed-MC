
# Points this tile toward the tile next to it that '#sec_a' names, 1 west, 2
#  east, 3 north and 4 south, in the glass a flood leaves for it
# Positioned on the tile

execute if score #sec_a dr_var matches 1 run setblock ~ ~2 ~ light_blue_stained_glass strict
execute if score #sec_a dr_var matches 2 run setblock ~ ~2 ~ cyan_stained_glass strict
execute if score #sec_a dr_var matches 3 run setblock ~ ~2 ~ blue_stained_glass strict
execute if score #sec_a dr_var matches 4 run setblock ~ ~2 ~ purple_stained_glass strict
