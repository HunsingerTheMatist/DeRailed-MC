
# Takes the river into the lakes it runs along, leaving the stretches that run
#  up to a lake as its inlet and outlet
# A river tile touches a lake where the lake's water lies along one of its
#  edges, and joins it where the next tile along the river touches the lake
#  too, so a river that runs straight into a lake or only grazes one keeps its
#  line; where the shore runs diagonally the river steps along it, touching
#  the lake only every other tile, and a tile with the lake only at a corner
#  joins where the tiles either side of it touch the lake
# The whole section is looked at before any of it changes, so a tile that joins
#  a lake never draws the river behind it in after it
# Positioned at the section's corner on the finished layer, once the section
#  has shipped

scoreboard players set #lake_z dr_var 0
function derailed:dev/gen/_lakeside_row

execute as @e[type=marker,tag=dr_shore,distance=0..] at @s if entity @e[type=marker,tag=dr_shore,distance=0.5..1.1] run tag @s add dr_join
execute as @e[type=marker,tag=dr_shore_near,distance=0..] at @s run function derailed:dev/gen/_lakeside_near

# A tile at a corner of the lake takes its region from a tile beside it that
#  joined, so it joins last
execute as @e[type=marker,tag=dr_shore,tag=dr_join,distance=0..] at @s run function derailed:dev/gen/_lakeside_join
execute as @e[type=marker,tag=dr_shore_near,tag=dr_join,distance=0..] at @s run function derailed:dev/gen/_lakeside_join
kill @e[type=marker,tag=dr_lakeside,distance=0..]
