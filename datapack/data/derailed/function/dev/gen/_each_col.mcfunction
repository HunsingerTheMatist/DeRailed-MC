
# Runs the function $(f) on this tile, then moves on to the one east of it
# Positioned on the tile

$function derailed:dev/gen/$(f)

scoreboard players add #each_x dr_var 1
execute if score #each_x dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_each_col with storage derailed:gen e
