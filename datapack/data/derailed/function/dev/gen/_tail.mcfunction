
# Steps from this seed toward the exit seed, only ever sideways or forward
# Once nothing lies between here and the exit row, joins the exit seed itself

execute if entity @n[type=marker,tag=dr_exit,tag=dr_chain,distance=0..] run return 0

scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail

execute store result storage derailed:gen t.x int 1 run data get entity @s Pos[0]
execute store result score #gen_z dr_var run data get entity @s Pos[2]

# A window spanning from this seed's row to the exit row, whichever way round
scoreboard players operation #gen_lo dr_var = #gen_z dr_var
scoreboard players operation #gen_hi dr_var = #gen_exit_z dr_var
execute if score #gen_z dr_var > #gen_exit_z dr_var run scoreboard players operation #gen_lo dr_var = #gen_exit_z dr_var
execute if score #gen_z dr_var > #gen_exit_z dr_var run scoreboard players operation #gen_hi dr_var = #gen_z dr_var
execute store result storage derailed:gen t.z int 1 run scoreboard players get #gen_lo dr_var
scoreboard players operation #gen_hi dr_var -= #gen_lo dr_var
execute store result storage derailed:gen t.dz int 1 run scoreboard players get #gen_hi dr_var

# Returning straight after the step keeps the fallback below from also running
execute store result score #gen_found dr_var run function derailed:dev/gen/_count_tail with storage derailed:gen t
execute if score #gen_found dr_var matches 1.. at @s run return run function derailed:dev/gen/_next_tail with storage derailed:gen t

execute as @n[type=marker,tag=dr_exit,distance=0..] run function derailed:dev/gen/_join_tail
