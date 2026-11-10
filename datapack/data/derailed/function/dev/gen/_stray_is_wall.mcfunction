
# Succeeds where this tile's region is on the wall
# Positioned on the tile, on the kinds layer

scoreboard players set #gen_id dr_var -1
function derailed:dev/gen/_read_id
execute if score #gen_id dr_var matches 0..25 as @e[type=marker,tag=dr_seed,tag=dr_wall,distance=0..] if score @s dr_id = #gen_id dr_var run return 1
return 0
