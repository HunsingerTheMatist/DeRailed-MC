
# Repaints this tile if it belongs to the region in 'p', then moves on to the
#  one east of it
# Positioned on the tile

function derailed:dev/gen/_repaint_at with storage derailed:gen p

scoreboard players add #each_x dr_var 1
execute if score #each_x dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_repaint_col
