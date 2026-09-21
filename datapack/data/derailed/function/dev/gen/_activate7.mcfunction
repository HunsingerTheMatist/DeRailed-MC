
# Hands this tile's region to the four neighbours a diagonal step away, then
#  retires the marker

scoreboard players operation #gen_id dr_var = @s dr_id

execute positioned ~1 ~ ~1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute positioned ~1 ~ ~-1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute positioned ~-1 ~ ~1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute positioned ~-1 ~ ~-1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim7 with storage derailed:gen a7

scoreboard players remove #gen_pending dr_var 1
kill @s
