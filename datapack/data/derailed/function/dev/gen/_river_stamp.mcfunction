
# Lays every tile the walk decided to keep
# The water goes on one tile of the four round the corner the head stood on,
#  the one the river's side puts it on, so a river is as wide as the line the
#  search walked and two corners next to each other are two tiles next to each
#  other, whichever way the line turned between them

execute as @e[type=marker,tag=dr_riv_keep,distance=0..] at @s run function derailed:dev/gen/_river_wet_at with storage derailed:gen rw
