
# Times 100 sections worth of seed scattering at (1000, 0, 0) in 'derailed:game'
# Where they landed can be seen by turning '#gen_marks' on, which stands one over
#  each of them

schedule function derailed:dev/bench/stop 1t
scoreboard players set #bench dr_var 1

scoreboard players set #bench_pass dr_var 0
scoreboard players set #wave_leftover dr_var 0
scoreboard players set #gen_pass dr_var 100
execute in derailed:game run function derailed:dev/gen/_pass

# Short of what was asked for means the spacing is crowding the section, since a
#  seed that cannot find a clear spot in 30 tries is skipped
execute in derailed:game store result score #gen_count dr_var if entity @e[type=marker,tag=dr_seed,distance=0..]
tellraw @a [{text:"[gen] seeds placed: ",color:"gray"},{score:{name:"#gen_count",objective:"dr_var"}},{text:" of 26"}]
