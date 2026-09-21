
# Records on the layer above which way the flood came onto this tile

execute if score #gen_from dr_var matches 1 run return run setblock ~ ~2 ~ light_blue_stained_glass strict
execute if score #gen_from dr_var matches 2 run return run setblock ~ ~2 ~ cyan_stained_glass strict
execute if score #gen_from dr_var matches 3 run return run setblock ~ ~2 ~ blue_stained_glass strict
execute if score #gen_from dr_var matches 4 run return run setblock ~ ~2 ~ purple_stained_glass strict
setblock ~ ~2 ~ white_stained_glass strict
