
# Hands this tile to the nearest of the seeds put up for it, on the base and
#  the kinds layer both, and puts light blue glass over it so the handing on can
#  be picked out from above
# Positioned on the tile

execute as @n[type=marker,tag=dr_near,distance=0..] run scoreboard players operation #gen_id dr_var = @s dr_id
function derailed:dev/gen/_set_id
execute positioned ~ ~5 ~ run function derailed:dev/gen/_set_id
setblock ~ ~16 ~ light_blue_stained_glass strict
tag @e[type=marker,tag=dr_near,distance=0..] remove dr_near
scoreboard players add #stray_n dr_var 1
