
# Counts this column's wood and iron tiles within reach, adds them to 'cols'
#  and to the tail where the column is one of the last fifteen, then moves one
#  column east
# Positioned on the column's northern tile

scoreboard players set #col_w dr_var 0
scoreboard players set #col_i dr_var 0

execute if block ~ ~ ~ brown_concrete if block ~ ~2 ~ #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~1 brown_concrete if block ~ ~2 ~1 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~2 brown_concrete if block ~ ~2 ~2 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~3 brown_concrete if block ~ ~2 ~3 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~4 brown_concrete if block ~ ~2 ~4 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~5 brown_concrete if block ~ ~2 ~5 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~6 brown_concrete if block ~ ~2 ~6 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~7 brown_concrete if block ~ ~2 ~7 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~8 brown_concrete if block ~ ~2 ~8 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~9 brown_concrete if block ~ ~2 ~9 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~10 brown_concrete if block ~ ~2 ~10 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~11 brown_concrete if block ~ ~2 ~11 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~12 brown_concrete if block ~ ~2 ~12 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~13 brown_concrete if block ~ ~2 ~13 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~14 brown_concrete if block ~ ~2 ~14 #derailed:flood_visited run scoreboard players add #col_w dr_var 1
execute if block ~ ~ ~15 brown_concrete if block ~ ~2 ~15 #derailed:flood_visited run scoreboard players add #col_w dr_var 1

execute if block ~ ~ ~ light_gray_concrete if block ~ ~2 ~ #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~1 light_gray_concrete if block ~ ~2 ~1 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~2 light_gray_concrete if block ~ ~2 ~2 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~3 light_gray_concrete if block ~ ~2 ~3 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~4 light_gray_concrete if block ~ ~2 ~4 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~5 light_gray_concrete if block ~ ~2 ~5 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~6 light_gray_concrete if block ~ ~2 ~6 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~7 light_gray_concrete if block ~ ~2 ~7 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~8 light_gray_concrete if block ~ ~2 ~8 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~9 light_gray_concrete if block ~ ~2 ~9 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~10 light_gray_concrete if block ~ ~2 ~10 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~11 light_gray_concrete if block ~ ~2 ~11 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~12 light_gray_concrete if block ~ ~2 ~12 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~13 light_gray_concrete if block ~ ~2 ~13 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~14 light_gray_concrete if block ~ ~2 ~14 #derailed:flood_visited run scoreboard players add #col_i dr_var 1
execute if block ~ ~ ~15 light_gray_concrete if block ~ ~2 ~15 #derailed:flood_visited run scoreboard players add #col_i dr_var 1

data modify storage derailed:gen cols append value {w:0,i:0}
execute store result storage derailed:gen cols[-1].w int 1 run scoreboard players get #col_w dr_var
execute store result storage derailed:gen cols[-1].i int 1 run scoreboard players get #col_i dr_var
execute if score #col_x dr_var matches 17.. run scoreboard players operation #tail_w dr_var += #col_w dr_var
execute if score #col_x dr_var matches 17.. run scoreboard players operation #tail_i dr_var += #col_i dr_var

scoreboard players add #col_x dr_var 1
execute if score #col_x dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_col_scan_at
