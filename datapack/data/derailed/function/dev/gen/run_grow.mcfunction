
# Times 21 whole sections at the test area, in runs of three chained together
# Fewer passes than the other benchmarks, since a section here is whole rather
#  than one stage of one

schedule function derailed:dev/bench/stop 1t
schedule function derailed:dev/gen/report 1t
scoreboard players set #bench dr_var 1

# Anything a previous run left behind would be timed along with this one, and the
#  stands over the seeds would pile up a couple of hundred deep
scoreboard players set #gen_marks dr_var 0
execute in derailed:game run kill @e[type=armor_stand,tag=dr_seed_mark]
execute in derailed:game run kill @e[type=marker,tag=dr_edge]
execute in derailed:game run kill @e[type=marker,tag=dr_prev_seed]
execute in derailed:game run function derailed:dev/gen/_kill_waves

scoreboard players set #bench_pass dr_var 0
scoreboard players set #wave_leftover dr_var 0
scoreboard players set #gen_rerolls dr_var 0
scoreboard players set #gen_failed dr_var 0
scoreboard players set #gen_fail_path dr_var 0
scoreboard players set #gen_cuts dr_var 0
scoreboard players set #gen_relieved dr_var 0
scoreboard players set #gen_wall_gaps dr_var 0
scoreboard players set #gen_fail_flat dr_var 0
scoreboard players set #gen_fail_cheap dr_var 0
scoreboard players set #gen_fail_dear dr_var 0
scoreboard players set #gen_rate_n dr_var 0
scoreboard players set #gen_rate_sum dr_var 0
scoreboard players set #gen_rate_lo dr_var 2147483647
scoreboard players set #gen_rate_hi dr_var 0
scoreboard players set #gen_no_river dr_var 0
scoreboard players set #riv_fell dr_var 0
scoreboard players set #riv_joins dr_var 0
scoreboard players set #riv_lakes dr_var 0
scoreboard players set #riv_cuts dr_var 0
scoreboard players set #riv_dry dr_var 0
scoreboard players set #gen_origin_x dr_var 1000
scoreboard players set #gen_pass dr_var 7
execute in derailed:game run function derailed:dev/gen/_pass_grow
