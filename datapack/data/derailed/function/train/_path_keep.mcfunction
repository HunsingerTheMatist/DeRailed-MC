
# Drops the tile at the back of the path once every axle is two tiles past it,
#  and where the path is a loop, adds another round of it once the frontmost
#  axle comes within 16 tiles of its end

scoreboard players set #lo dr_temp 2147483647
scoreboard players set #hi dr_temp 0
execute as @e[type=marker,tag=dr_axle,distance=0..] run scoreboard players operation #lo dr_temp < @s dr_ai
execute as @e[type=marker,tag=dr_axle,distance=0..] run scoreboard players operation #hi dr_temp > @s dr_ai
execute if score #lo dr_temp matches 2.. run function derailed:train/_path_drop

execute unless data storage derailed:train loop[0] run return 0
execute store result score #n dr_temp run data get storage derailed:train path
scoreboard players remove #n dr_temp 16
execute if score #hi dr_temp >= #n dr_temp run data modify storage derailed:train path append from storage derailed:train loop[]
