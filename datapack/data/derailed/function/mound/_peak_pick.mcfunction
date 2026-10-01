
# Tags 'dr_mound_peak' a corner two or more tiles in not yet a peak, taken at
#  random, then another while '#mp' wants more

execute store result score #mq dr_temp if entity @e[type=marker,tag=dr_mound_c,tag=!dr_mound_peak,scores={dr_md=2..},distance=0..]
execute if score #mq dr_temp matches 0 run return 0
scoreboard players set #mlo dr_temp 0
scoreboard players operation #mhi dr_temp = #mq dr_temp
scoreboard players remove #mhi dr_temp 1
function derailed:mound/_rand
execute as @e[type=marker,tag=dr_mound_c,tag=!dr_mound_peak,scores={dr_md=2..},distance=0..] run function derailed:mound/_peak_count

scoreboard players remove #mp dr_temp 1
execute if score #mp dr_temp matches 1.. run function derailed:mound/_peak_pick
