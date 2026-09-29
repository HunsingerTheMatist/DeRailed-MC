
# Lays stretch '#sec_t' from the tile it is joined at up to '#sec_end', where
#  the way leaves it, then the detour that reached it, walked back by the ways
#  the search from the stretch it came from kept, and goes back to that stretch
# Positioned at the section's corner

scoreboard players remove #sec_guard dr_var 1
execute if score #sec_guard dr_var matches ..0 run return fail

scoreboard players set #sec_m dr_var 0
execute as @e[type=marker,tag=dr_rej,distance=0..] if score @s dr_str = #sec_t dr_var run scoreboard players operation #sec_m dr_var = @s dr_step
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_step >= #sec_m dr_var if score @s dr_step < #sec_end dr_var at @s run function derailed:dev/gen/_sec_arrow_own
execute if score #sec_t dr_var matches ..0 run return 0

execute as @e[type=marker,tag=dr_rej,distance=0..] if score @s dr_str = #sec_t dr_var run scoreboard players operation #sec_s dr_var = @s dr_from
execute as @e[type=marker,tag=dr_rej,distance=0..] if score @s dr_str = #sec_t dr_var run scoreboard players operation #sec_via dr_var = @s dr_via

scoreboard players operation #sec_y dr_var = #sec_s dr_var
scoreboard players add #sec_y dr_var 6
execute store result storage derailed:gen sk.y int 1 run scoreboard players get #sec_y dr_var
function derailed:dev/gen/_sec_load with storage derailed:gen sk

scoreboard players set #sec_len dr_var 0
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_step = #sec_m dr_var at @s run function derailed:dev/gen/_sec_det_start
scoreboard players operation #sec_detour_max dr_var > #sec_len dr_var

scoreboard players operation #sec_t dr_var = #sec_s dr_var
function derailed:dev/gen/_sec_build_step
