
# Gives this tile '#mk' as its depth where any of the four beside it is '#mprev'
#  deep, or any of the four at its corners while '#mdiag' is set; one past the
#  ring round the map is no tile and says nothing
# Run as the tile's marker, at it

scoreboard players set #mf dr_temp 0
execute positioned ~1 ~ ~ as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute positioned ~-1 ~ ~ as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute positioned ~ ~ ~1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute positioned ~ ~ ~-1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute if score #mdiag dr_temp matches 1 positioned ~1 ~ ~1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute if score #mdiag dr_temp matches 1 positioned ~1 ~ ~-1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute if score #mdiag dr_temp matches 1 positioned ~-1 ~ ~1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute if score #mdiag dr_temp matches 1 positioned ~-1 ~ ~-1 as @e[type=marker,tag=dr_mound_t,distance=..0.5] if score @s dr_md = #mprev dr_temp run scoreboard players set #mf dr_temp 1
execute if score #mf dr_temp matches 1 run scoreboard players operation @s dr_md = #mk dr_temp
