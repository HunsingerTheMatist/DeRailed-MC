
# Tags this corner 'dr_mound_peak' where '#mj' has counted down to it
# Run as the corner's marker

execute if score #mj dr_temp matches 0 run tag @s add dr_mound_peak
scoreboard players remove #mj dr_temp 1
