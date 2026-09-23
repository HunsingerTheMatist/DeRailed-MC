
# Runs one section worth of wave driven growth: schedule 512 tiles, spread them
#  over 45 waves, then wake the waves in order

scoreboard players set #wave_z dr_var 16
execute positioned 1000.0 0.0 0.0 run function derailed:dev/wave/_row

# One scan handing every pending marker its due wave
execute as @e[type=marker,tag=dr_bench] store result score @s dr_wave run random value 1..45

# One more than the largest wave, since a wave is woken before it is aged
scoreboard players set #wave_n dr_var 46
function derailed:dev/wave/_wave

# Anything left never came due, which would mean the wave count is too low
execute if entity @e[type=marker,tag=dr_bench] run scoreboard players add #wave_leftover dr_var 1
kill @e[type=marker,tag=dr_bench]

scoreboard players remove #wave_pass dr_var 1
execute if score #wave_pass dr_var matches 1.. run function derailed:dev/wave/_pass
