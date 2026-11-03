
# Drops the tile at the back of this train's team's path once every axle of
#  the team is two tiles past it, and where the path is a loop, adds another
#  round of it once the frontmost axle comes within 16 tiles of its end
# Run as the train's engine

scoreboard players operation #team dr_temp = @s dr_team
scoreboard players set #lo dr_temp 2147483647
scoreboard players set #hi dr_temp 0
execute as @e[type=marker,tag=dr_axle,distance=0..] if score @s dr_team = #team dr_temp run scoreboard players operation #lo dr_temp < @s dr_ai
execute as @e[type=marker,tag=dr_axle,distance=0..] if score @s dr_team = #team dr_temp run scoreboard players operation #hi dr_temp > @s dr_ai

execute store result storage derailed:train arg.team int 1 run scoreboard players get #team dr_temp
execute if score #lo dr_temp matches 2.. run function derailed:train/_path_drop with storage derailed:train arg
function derailed:train/_path_loop with storage derailed:train arg
