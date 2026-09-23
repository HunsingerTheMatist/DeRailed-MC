
# Clears the benchmark area, reports whether the run finished, and lets the game
#  tick run again

# Anything above 0 means the chain was cut short and the timing covers only part
#  of the run
tellraw @a [{text:"[bench] passes left unrun: ",color:"gray"},{score:{name:"#bench_pass",objective:"dr_var"}},{text:"   wave passes with markers left over: "},{score:{name:"#wave_leftover",objective:"dr_var"}}]

scoreboard players set #bench dr_var 0

# A run turns the stands over the seeds off to keep them out of the timing, and
#  putting them back is this one's to do: a map looked at afterwards would come
#  up bare otherwise
scoreboard players set #gen_marks dr_var 1
execute in derailed:game run kill @e[type=marker,tag=dr_bench]
execute in derailed:game run function derailed:dev/gen/_kill_waves
execute in derailed:game run kill @e[type=marker,tag=dr_edge]
execute in derailed:game run kill @e[type=marker,tag=dr_prev_seed]
execute in derailed:game run kill @e[type=marker,tag=dr_seam_wait]
execute in derailed:game run kill @e[type=marker,tag=dr_riv_path]
execute in derailed:game run kill @e[type=marker,tag=dr_riv_node]
execute in derailed:game run kill @e[type=marker,tag=dr_riv_head]
execute in derailed:game run kill @e[type=marker,tag=dr_riv_best]
execute in derailed:game run kill @e[type=marker,tag=dr_riv_seed]
execute in derailed:game run kill @e[type=marker,tag=dr_flood]
execute in derailed:game run kill @e[type=marker,tag=dr_cut]
execute in derailed:game run kill @e[type=marker,tag=dr_cut_run]
execute in derailed:game run kill @e[type=marker,tag=dr_pinch]
execute in derailed:game run kill @e[type=armor_stand,tag=dr_seed_mark]
function derailed:dev/gen/clear
