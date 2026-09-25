
# Counts this corner against the side being tried if the tile it would wet
#  carves a prefab or lies across the seam
# Run as the corner's marker, positioned on it

execute store result score #riv_cx dr_var run data get entity @s Pos[0]
scoreboard players operation #riv_cx dr_var -= #gen_corner dr_var
function derailed:dev/gen/_river_side_see with storage derailed:gen rw
