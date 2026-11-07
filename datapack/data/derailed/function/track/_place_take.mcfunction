# Puts team $(team)'s take interactions on the rail of the end of its track,
#  tagged 'dr_end_on', in place of those it had, where there is a rail before
#  the last to be the end once it is taken, and leaves it none otherwise
# Two stand on the rail's two ends, where a straight rail running out by each
#  edge would have them, 0.75 out from the middle toward the edge it comes in
#  by and toward the one it leaves by; a turned rail has a third, narrower, on
#  its middle block. Each is as tall as a rail and a hundredth of a block wider
#  than the blocks it covers, so it reaches just past their faces and a click
#  on the rail lands on it rather than on them
# Run in the game's dimension

$scoreboard players set #team dr_temp $(team)
execute as @e[type=interaction,tag=dr_track_take,distance=0..] if score @s dr_team = #team dr_temp run kill @s
$execute unless data storage derailed:track t$(team).rails[1] run return 0
execute at @n[type=marker,tag=dr_end_on,distance=0..] run summon interaction ~ ~ ~ {Tags:["dr_track_take","dr_take_new","dr_take_a"],width:1.51f,height:0.28125f}
execute at @n[type=marker,tag=dr_end_on,distance=0..] run summon interaction ~ ~ ~ {Tags:["dr_track_take","dr_take_new","dr_take_b"],width:1.51f,height:0.28125f}
scoreboard players operation @e[type=interaction,tag=dr_take_new,distance=0..] dr_team = #team dr_temp

# The edge the rail comes in by, '#a', and the one it leaves by, '#b', each as
#  a block's step toward it
scoreboard players operation #a dr_temp = @n[type=marker,tag=dr_end_on,distance=0..] dr_adin
scoreboard players add #a dr_temp 2
scoreboard players operation #a dr_temp %= $Four dr_const
scoreboard players operation #b dr_temp = @n[type=marker,tag=dr_end_on,distance=0..] dr_adout
scoreboard players set #ax dr_temp 0
scoreboard players set #az dr_temp 0
scoreboard players set #bx dr_temp 0
scoreboard players set #bz dr_temp 0
execute if score #a dr_temp matches 0 run scoreboard players set #az dr_temp -1
execute if score #a dr_temp matches 1 run scoreboard players set #ax dr_temp 1
execute if score #a dr_temp matches 2 run scoreboard players set #az dr_temp 1
execute if score #a dr_temp matches 3 run scoreboard players set #ax dr_temp -1
execute if score #b dr_temp matches 0 run scoreboard players set #bz dr_temp -1
execute if score #b dr_temp matches 1 run scoreboard players set #bx dr_temp 1
execute if score #b dr_temp matches 2 run scoreboard players set #bz dr_temp 1
execute if score #b dr_temp matches 3 run scoreboard players set #bx dr_temp -1
execute store result storage derailed:track at.xa double 0.75 run scoreboard players get #ax dr_temp
execute store result storage derailed:track at.za double 0.75 run scoreboard players get #az dr_temp
execute store result storage derailed:track at.xb double 0.75 run scoreboard players get #bx dr_temp
execute store result storage derailed:track at.zb double 0.75 run scoreboard players get #bz dr_temp
execute at @n[type=marker,tag=dr_end_on,distance=0..] run function derailed:track/_take_move with storage derailed:track at

execute unless score #b dr_temp = @n[type=marker,tag=dr_end_on,distance=0..] dr_adin at @n[type=marker,tag=dr_end_on,distance=0..] run \
    summon interaction ~ ~-0.5 ~ {Tags:["dr_track_take","dr_take_new"],width:1.01f,height:0.28125f}
scoreboard players operation @e[type=interaction,tag=dr_take_new,distance=0..] dr_team = #team dr_temp
tag @e[type=interaction,tag=dr_take_new,distance=0..] remove dr_take_new
