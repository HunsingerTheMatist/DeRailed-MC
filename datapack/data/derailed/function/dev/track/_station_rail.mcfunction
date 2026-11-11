# Lays the rail of the tile the end of the track, tagged 'dr_end_on', stands on
#  straight east as a track tile of team '#train_team', puts it on the end of
#  the team's path and rails, the first of them both where '#rail_n' is 0, then
#  moves the end a tile east and does the same there, up to the seventh

execute at @n[type=marker,tag=dr_end_on,distance=0..] summon marker run function derailed:dev/track/_tile
scoreboard players set #din dr_temp 1
scoreboard players set #dout dr_temp 1
execute at @n[type=marker,tag=dr_end_on,distance=0..] positioned ~-1 ~ ~-1 run function derailed:track/lay_rails

data modify storage derailed:train new set value {x:0,z:0,din:1,dout:1,len:3000}
execute store result storage derailed:train new.x int 1 run data get entity @n[type=marker,tag=dr_end_on,distance=0..] Pos[0] 1000
execute store result storage derailed:train new.z int 1 run data get entity @n[type=marker,tag=dr_end_on,distance=0..] Pos[2] 1000
execute if score #rail_n dr_temp matches 0 run function derailed:dev/track/_path with storage derailed:train arg
execute if score #rail_n dr_temp matches 1.. run function derailed:track/_path_lay with storage derailed:train arg

scoreboard players add #rail_n dr_temp 1
execute if score #rail_n dr_temp matches 7.. run return 0
execute as @n[type=marker,tag=dr_end_on,distance=0..] at @s run tp @s ~3 ~ ~
function derailed:dev/track/_station_rail
