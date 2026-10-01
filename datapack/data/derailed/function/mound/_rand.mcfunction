
# Takes a number at random from '#mlo' to '#mhi' into '#mj', and returns it

execute store result score #mj dr_temp run random value 0..2147483646 derailed:terrain
scoreboard players operation #mspan dr_temp = #mhi dr_temp
scoreboard players operation #mspan dr_temp -= #mlo dr_temp
scoreboard players add #mspan dr_temp 1
scoreboard players operation #mj dr_temp %= #mspan dr_temp
scoreboard players operation #mj dr_temp += #mlo dr_temp
return run scoreboard players get #mj dr_temp
