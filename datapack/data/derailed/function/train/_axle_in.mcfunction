
# Stands this axle on the line it came into its tile along, from the middle of
#  the edge it came in by
# Run as the axle's marker, with the way in in '#dix' and '#diz'

scoreboard players operation #t dr_temp = @s dr_ad
scoreboard players remove #t dr_temp 1500
scoreboard players operation #x dr_temp = #dix dr_temp
scoreboard players operation #x dr_temp *= #t dr_temp
execute store result entity @s Pos[0] double 0.001 run scoreboard players operation #x dr_temp += @s dr_acx
scoreboard players operation #z dr_temp = #diz dr_temp
scoreboard players operation #z dr_temp *= #t dr_temp
execute store result entity @s Pos[2] double 0.001 run scoreboard players operation #z dr_temp += @s dr_acz
