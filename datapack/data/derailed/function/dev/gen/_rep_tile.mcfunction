
# Counts this tile for the scan, where the flood got to it and the river does
#  not run over it: onto column $(c)'s wood or iron, and onto the seed of its
#  region where that is one of this section's own
# Positioned on the tile, with the flood's marks two above, the regions cuts
#  gave tiles two below and the regions as they grew fifteen below

execute unless block ~ ~2 ~ #derailed:flood_visited run return 0
execute if block ~ ~ ~ light_blue_concrete run return 0
$execute if block ~ ~ ~ brown_concrete run scoreboard players add #c_w$(c) dr_var 1
$execute if block ~ ~ ~ light_gray_concrete run scoreboard players add #c_i$(c) dr_var 1
function derailed:dev/gen/_read_owner
$execute if score #gen_id dr_var matches 0..25 as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run function derailed:dev/gen/_rep_tile_seed {c:$(c)}
