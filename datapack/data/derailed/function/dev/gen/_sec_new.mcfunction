
# Sets up the marker just left on a tile the search reached, and marks the
#  tile four above in the glass a flood leaves for the way it was reached from
# Run as the marker, positioned on the tile

tag @s add dr_bq
scoreboard players operation @s dr_rock = #sec_nr dr_var
scoreboard players operation @s dr_depth = #sec_nd dr_var
execute if score #sec_back dr_var matches 1 run return run setblock ~ ~4 ~ light_blue_stained_glass strict
execute if score #sec_back dr_var matches 2 run return run setblock ~ ~4 ~ cyan_stained_glass strict
execute if score #sec_back dr_var matches 3 run return run setblock ~ ~4 ~ blue_stained_glass strict
setblock ~ ~4 ~ purple_stained_glass strict
