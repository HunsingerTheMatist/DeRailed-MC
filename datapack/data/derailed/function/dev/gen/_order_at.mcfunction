
# Counts this tile onto the wave it was taken on, the water on the way to it
#  from the entry
# Run as the flood's marker on the tile

execute store result storage derailed:gen o.w int 1 run scoreboard players get #cost_wave dr_var
function derailed:dev/gen/_order_count with storage derailed:gen o
