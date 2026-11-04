# Derails this train where its engine's front axle would be past the end of
#  its track after its next move, over a tile with no rail
# Run as the train's engine

scoreboard players operation #tid dr_temp = @s dr_tid
scoreboard players set #ahead dr_arg 0
scoreboard players set #ran_out dr_temp 0
execute as @e[type=marker,tag=dr_axle,tag=dr_axle_front,distance=0..] if score @s dr_tid = #tid dr_temp if function derailed:train/_runs_out run scoreboard players set #ran_out dr_temp 1
execute if score #ran_out dr_temp matches 1 run function derailed:train/derail
