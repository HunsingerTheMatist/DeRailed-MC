
# Puts the seed of the region on this tile up to take the stray, where the
#  region has one here
# Positioned on the tile, on the kinds layer

scoreboard players set #gen_id dr_var -1
function derailed:dev/gen/_read_id
execute if score #gen_id dr_var matches 0..25 as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run tag @s add dr_near
