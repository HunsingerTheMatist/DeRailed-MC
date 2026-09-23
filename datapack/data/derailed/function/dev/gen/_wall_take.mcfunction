
# Puts the region under this tile on the band
# A region carried over the seam has no seed here and keeps the kind it came
#  with, so one that is not rock already is a hole in the band, as is a tile no
#  region took, and both are counted
# Positioned on the tile

scoreboard players set #gen_id dr_var -1
function derailed:dev/gen/_read_id
execute unless score #gen_id dr_var matches 0..25 unless score #gen_id dr_var matches 30 run scoreboard players add #wall_gap dr_var 1
execute as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run tag @s add dr_wall
