
# Tags this river tile 'dr_big_seg', keeps its row in '#s_r1', and goes on to
#  the river tile it flows into while that is not followed yet
# Positioned at the river tile

scoreboard players add #s_len dr_temp 1
execute if score #s_len dr_temp matches 600.. run return 0
scoreboard players set #s_d dr_temp -1
execute as @n[type=marker,tag=dr_big_river,distance=..0.5] run function derailed:dev/big/_south_mark_at
execute if score #s_d dr_temp matches 0 positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_done,tag=!dr_big_seg,distance=..0.5] run return run function derailed:dev/big/_south_mark
execute if score #s_d dr_temp matches 1 positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_done,tag=!dr_big_seg,distance=..0.5] run return run function derailed:dev/big/_south_mark
execute if score #s_d dr_temp matches 2 positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_done,tag=!dr_big_seg,distance=..0.5] run return run function derailed:dev/big/_south_mark
execute if score #s_d dr_temp matches 3 positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_done,tag=!dr_big_seg,distance=..0.5] run function derailed:dev/big/_south_mark
