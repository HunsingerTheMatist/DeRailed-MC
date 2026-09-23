
# Hands this tile's region to the four neighbours a diagonal step away, each
#  only where one of the two tiles between holds this region already, so that
#  every tile of a region meets it along an edge and none hangs off a corner
#  alone; a corner refused here goes to whichever region reaches it straight on
# Then retires the marker

scoreboard players operation #gen_id dr_var = @s dr_id

execute if block ~1 ~ ~1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~1 ~ ~ all positioned ~1 ~ ~1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~1 ~ ~1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~ ~ ~1 all positioned ~1 ~ ~1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~1 ~ ~-1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~1 ~ ~ all positioned ~1 ~ ~-1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~1 ~ ~-1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~ ~ ~-1 all positioned ~1 ~ ~-1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~-1 ~ ~1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~-1 ~ ~ all positioned ~-1 ~ ~1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~-1 ~ ~1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~ ~ ~1 all positioned ~-1 ~ ~1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~-1 ~ ~-1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~-1 ~ ~ all positioned ~-1 ~ ~-1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7
execute if block ~-1 ~ ~-1 black_concrete if blocks ~ ~ ~ ~ ~ ~ ~ ~ ~-1 all positioned ~-1 ~ ~-1 run function derailed:dev/gen/_claim7 with storage derailed:gen a7

scoreboard players remove #gen_pending dr_var 1
kill @s
