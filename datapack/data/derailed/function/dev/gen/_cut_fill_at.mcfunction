
# Makes this cut tile the terrain in '#cut_fill', on the visible layer and the
#  kinds layer both
# Positioned on the tile

execute if score #cut_fill dr_var matches 0 run setblock ~ ~ ~ lime_concrete strict
execute if score #cut_fill dr_var matches 1 run setblock ~ ~ ~ brown_concrete strict
execute if score #cut_fill dr_var matches 2 run setblock ~ ~ ~ light_gray_concrete strict
execute if score #cut_fill dr_var matches 5 run setblock ~ ~ ~ light_blue_concrete strict
clone ~ ~ ~ ~ ~ ~ ~ ~-10 ~ strict
