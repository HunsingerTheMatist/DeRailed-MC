
# Works out this corner's depth, the least of the four tiles round it, and from
#  that how high it stands: a start taken at random, a share taken at random of
#  the rise for its depth, and a little either way for any corner inside a
#  region
# Run as the corner's marker, at it

scoreboard players set #mc dr_temp 99
execute positioned ~-1 ~-1 ~-1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] run scoreboard players operation #mc dr_temp < @s dr_md
execute positioned ~ ~-1 ~-1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] run scoreboard players operation #mc dr_temp < @s dr_md
execute positioned ~-1 ~-1 ~ as @e[type=marker,tag=dr_mound_t,distance=..0.5] run scoreboard players operation #mc dr_temp < @s dr_md
execute positioned ~ ~-1 ~ as @e[type=marker,tag=dr_mound_t,distance=..0.5] run scoreboard players operation #mc dr_temp < @s dr_md
scoreboard players operation @s dr_md = #mc dr_temp

execute if score #mc dr_temp matches 6.. run scoreboard players set #mc dr_temp 5
execute if score #mc dr_temp matches 0 run scoreboard players operation @s dr_mh = #mr0 dr_temp
execute if score #mc dr_temp matches 1 run scoreboard players operation @s dr_mh = #mr1 dr_temp
execute if score #mc dr_temp matches 2 run scoreboard players operation @s dr_mh = #mr2 dr_temp
execute if score #mc dr_temp matches 3 run scoreboard players operation @s dr_mh = #mr3 dr_temp
execute if score #mc dr_temp matches 4 run scoreboard players operation @s dr_mh = #mr4 dr_temp
execute if score #mc dr_temp matches 5 run scoreboard players operation @s dr_mh = #mr5 dr_temp

scoreboard players operation #mlo dr_temp = #mrmin dr_temp
scoreboard players operation #mhi dr_temp = #mrmax dr_temp
function derailed:mound/_rand
scoreboard players operation @s dr_mh *= #mj dr_temp
scoreboard players operation @s dr_mh /= #m100 dr_temp
scoreboard players operation #mlo dr_temp = #msmin dr_temp
scoreboard players operation #mhi dr_temp = #msmax dr_temp
function derailed:mound/_rand
scoreboard players operation @s dr_mh += #mj dr_temp

scoreboard players operation #mv dr_temp = #mnoise dr_temp
execute if score @s dr_md matches 1.. run function derailed:mound/_nudge
execute if score @s dr_md matches 1.. run scoreboard players operation @s dr_mh += #mj dr_temp
