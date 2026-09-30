
# Looks at this tile, then moves on to the one east of it
# Positioned on the tile

execute if block ~ ~ ~ light_blue_concrete run function derailed:dev/gen/_lakeside_at

scoreboard players add #lake_x dr_var 1
execute if score #lake_x dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_lakeside_col
