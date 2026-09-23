
# Lays the longest line the search managed, for a river none of whose starts
#  reached an exit

scoreboard players set #riv_done dr_var 1
scoreboard players add #riv_fell dr_var 1

scoreboard players operation #riv_col_got dr_var = #riv_best_col dr_var

execute as @e[type=marker,tag=dr_riv_best,distance=0..] run tag @s add dr_riv_line
function derailed:dev/gen/_river_shorten

# A river that stops in the middle of dry ground reads as unfinished, so one of
#  the regions it ran out against is turned to water and it ends in a lake
execute as @n[type=marker,tag=dr_riv_end,distance=0..] at @s run function derailed:dev/gen/_river_lake
function derailed:dev/gen/_river_show
