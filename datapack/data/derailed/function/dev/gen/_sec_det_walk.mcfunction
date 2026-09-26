
# Points this tile of the detour the way '#sec_a' names, toward the tile after
#  it toward the entry, then steps back to the tile the search reached it from,
#  until the tile of the first route the detour left, which is pointed the
#  same way and whose number goes into '#sec_end'
# Positioned on the tile

function derailed:dev/gen/_sec_arrow
execute if entity @n[type=marker,tag=dr_rp,distance=..0.4] run return run execute as @n[type=marker,tag=dr_rp,distance=..0.4] run scoreboard players operation #sec_end dr_var = @s dr_step
scoreboard players add #sec_len dr_var 1
scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail

execute as @n[type=marker,tag=dr_bq,distance=..0.4] run scoreboard players operation #sec_d2 dr_var = @s dr_dir
scoreboard players set #sec_a dr_var 2
execute if score #sec_d2 dr_var matches 2 run scoreboard players set #sec_a dr_var 1
execute if score #sec_d2 dr_var matches 3 run scoreboard players set #sec_a dr_var 4
execute if score #sec_d2 dr_var matches 4 run scoreboard players set #sec_a dr_var 3
execute if score #sec_d2 dr_var matches 1 positioned ~-1 ~ ~ run return run function derailed:dev/gen/_sec_det_walk
execute if score #sec_d2 dr_var matches 2 positioned ~1 ~ ~ run return run function derailed:dev/gen/_sec_det_walk
execute if score #sec_d2 dr_var matches 3 positioned ~ ~ ~-1 run return run function derailed:dev/gen/_sec_det_walk
execute if score #sec_d2 dr_var matches 4 positioned ~ ~ ~1 run return run function derailed:dev/gen/_sec_det_walk
