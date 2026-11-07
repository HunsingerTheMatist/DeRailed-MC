# Succeeds where team $(team)'s track, its end tagged 'dr_end_on', has a rail
#  before its last to be the end once it is taken, its path runs to no loop,
#  and no axle of its train is on the path's last tile, which goes in '#last'
# Run in the game's dimension

execute unless entity @n[type=marker,tag=dr_end_on,distance=0..] run return fail
$execute unless data storage derailed:track t$(team).rails[1] run return fail
$execute unless data storage derailed:train t$(team).path[1] run return fail
$execute if data storage derailed:train t$(team).loop[0] run return fail
$execute store result score #last dr_temp run data get storage derailed:train t$(team).path
scoreboard players remove #last dr_temp 1
execute as @e[type=marker,tag=dr_axle,distance=0..] if score @s dr_team = #team dr_temp if score @s dr_ai >= #last dr_temp run return fail
return 1
