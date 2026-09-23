
# Looks at this tile, then moves on to the one east of it
# Positioned on the tile

function derailed:dev/gen/_stray_at

scoreboard players add #stray_x dr_var 1
execute if score #stray_x dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_stray_col
