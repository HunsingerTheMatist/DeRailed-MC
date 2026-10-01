
# Raises one to as many corners as '#mpeaks' at random two or more tiles in,
#  where at least three are, by twice '#mpk' pixels, and every corner of a
#  region beside one by '#mpk', so that a big mound has humps rather than one
#  summit

execute store result score #mq dr_temp if entity @e[type=marker,tag=dr_mound_c,scores={dr_md=2..},distance=0..]
execute if score #mq dr_temp matches ..2 run return 0

scoreboard players operation #mp dr_temp = #mpeaks dr_temp
scoreboard players set #mlo dr_temp 1
scoreboard players operation #mhi dr_temp = #mpeaks dr_temp
execute if score #mpeaks dr_temp matches 2.. store result score #mp dr_temp run function derailed:mound/_rand
execute if score #mp dr_temp matches 1.. run function derailed:mound/_peak_pick

execute as @e[type=marker,tag=dr_mound_c,scores={dr_md=1..},distance=0..] at @s if entity @e[type=marker,tag=dr_mound_peak,distance=..1.5] run scoreboard players operation @s dr_mh += #mpk dr_temp
execute as @e[type=marker,tag=dr_mound_peak,distance=0..] run scoreboard players operation @s dr_mh += #mpk dr_temp
tag @e[type=marker,tag=dr_mound_peak,distance=0..] remove dr_mound_peak
