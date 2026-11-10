
# Starts this tile of the first column growing as the void on the wave it would
#  reach it on from the nearest of its three starts, unless it is taken
#  already, then the next row south, as far as the last
# Positioned on the tile

scoreboard players operation #gx dr_temp = #void_ka dr_var
scoreboard players operation #gz dr_temp = #void_r dr_var
scoreboard players operation #gz dr_temp -= #void_a dr_var
function derailed:dev/gen/_grow_waves
scoreboard players operation #va dr_temp = #gw dr_temp
scoreboard players operation #gx dr_temp = #void_kb dr_var
scoreboard players operation #gz dr_temp = #void_r dr_var
scoreboard players operation #gz dr_temp -= #void_b dr_var
function derailed:dev/gen/_grow_waves
scoreboard players operation #va dr_temp < #gw dr_temp
scoreboard players operation #gx dr_temp = #void_kc dr_var
scoreboard players operation #gz dr_temp = #void_r dr_var
scoreboard players operation #gz dr_temp -= #void_c dr_var
function derailed:dev/gen/_grow_waves
scoreboard players operation #va dr_temp < #gw dr_temp
execute store result storage derailed:gen v.wake int 1 run scoreboard players get #va dr_temp
execute if block ~ ~ ~ black_concrete run function derailed:dev/gen/_void_at with storage derailed:gen v

scoreboard players add #void_r dr_var 1
execute if score #void_r dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_void_row
