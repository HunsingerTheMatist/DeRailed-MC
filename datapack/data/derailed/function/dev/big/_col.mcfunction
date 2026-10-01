
# Looks at this tile, then moves on to the one east of it
# Positioned on the tile

function derailed:dev/big/_tile

scoreboard players add #big_x dr_temp 1
execute if score #big_x dr_temp matches ..31 positioned ~1 ~ ~ run function derailed:dev/big/_col
