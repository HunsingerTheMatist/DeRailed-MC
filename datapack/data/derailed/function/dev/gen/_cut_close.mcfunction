
# Closes the run of rock the trace was in, with what is in '#cut_k' as its end
#  on the entry side

execute as @e[type=marker,tag=dr_cut_run,distance=0..] if score @s dr_step = #cut_runs dr_var run scoreboard players operation @s dr_id = #cut_k dr_var
scoreboard players set #cut_open dr_var 0
