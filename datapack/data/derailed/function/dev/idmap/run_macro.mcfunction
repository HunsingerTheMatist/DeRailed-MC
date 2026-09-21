# Times 100 sections worth of the 'macro' mapping over 150 regions, at (1000, 0, 0)
#  in 'derailed:game'

schedule function derailed:dev/bench/stop 1t
scoreboard players set #bench dr_var 1

scoreboard players set #bench_pass dr_var 0
scoreboard players set #wave_leftover dr_var 0
scoreboard players set #idmap_pass dr_var 100
execute in derailed:game run function derailed:dev/idmap/macro/_pass
