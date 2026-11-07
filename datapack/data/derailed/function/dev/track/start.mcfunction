# Starts the player's team's track on the tile the player stands on, the map's
#  tiles three blocks across from its corner at x1100 z0: a straight rail
#  across it the way they face, which is a track tile, the end of the track,
#  the only rail in the team's rails and the whole of the path its train runs
#  on, at the height of the block they stand in, with the tiles the next rail
#  could go on marked and no take interactions, since there is no rail before
#  it; takes the team's train away first, and the end, next tiles, track tiles,
#  rails and take interactions of any track it had before, the station's
#  excepted, and any track tile on no team
# Run as a player in the game, on a team

scoreboard players operation #train_team dr_temp = @s dr_team
execute if score #train_team dr_temp matches 0 run return run tellraw @s "Join a team first, /team join dr_red or dr_blue"
execute store result storage derailed:train arg.team int 1 run scoreboard players get #train_team dr_temp
function derailed:dev/train/clear with storage derailed:train arg
execute as @e[type=marker,tag=dr_track_end,distance=0..] if score @s dr_team = #train_team dr_temp run kill @s
execute as @e[type=marker,tag=dr_track_next,distance=0..] if score @s dr_team = #train_team dr_temp run kill @s
function derailed:dev/track/clear

# The tile's middle block, and the way they face, 0 north, 1 east, 2 south and
#  3 west, from a facing of 0 south and 90 west
execute store result score #tx dr_temp run data get entity @s Pos[0]
execute store result score #ty dr_temp run data get entity @s Pos[1]
execute store result score #tz dr_temp run data get entity @s Pos[2]
scoreboard players remove #tx dr_temp 1100
scoreboard players operation #tx dr_temp /= $TileSize dr_const
scoreboard players operation #tx dr_temp *= $TileSize dr_const
scoreboard players add #tx dr_temp 1101
scoreboard players operation #tz dr_temp /= $TileSize dr_const
scoreboard players operation #tz dr_temp *= $TileSize dr_const
scoreboard players add #tz dr_temp 1
execute store result score #d dr_temp run data get entity @s Rotation[0]
scoreboard players add #d dr_temp 405
scoreboard players operation #d dr_temp /= $RotationStep dr_const
scoreboard players add #d dr_temp 2
scoreboard players operation #d dr_temp %= $Four dr_const

# Piles put down round it are put down as on the map
scoreboard players operation #wx0 dr_temp = #tx dr_temp
scoreboard players remove #wx0 dr_temp 1
scoreboard players operation #wx1 dr_temp = #tx dr_temp
scoreboard players add #wx1 dr_temp 1
scoreboard players operation #wz0 dr_temp = #tz dr_temp
scoreboard players remove #wz0 dr_temp 1
scoreboard players operation #wz1 dr_temp = #tz dr_temp
scoreboard players add #wz1 dr_temp 1
scoreboard players operation #wy dr_temp = #ty dr_temp
function derailed:dev/widen_map

tag @e[type=marker,tag=dr_end_on,distance=0..] remove dr_end_on
execute summon marker run function derailed:dev/track/_end
execute at @n[type=marker,tag=dr_end_on,distance=0..] summon marker run function derailed:dev/track/_tile
scoreboard players operation #din dr_temp = #d dr_temp
scoreboard players operation #dout dr_temp = #d dr_temp
execute at @n[type=marker,tag=dr_end_on,distance=0..] positioned ~-1 ~ ~-1 run function derailed:track/lay_rails

data modify storage derailed:train new set value {x:0,z:0,din:0,dout:0,len:3000}
execute store result storage derailed:train new.x int 1 run data get entity @n[type=marker,tag=dr_end_on,distance=0..] Pos[0] 1000
execute store result storage derailed:train new.z int 1 run data get entity @n[type=marker,tag=dr_end_on,distance=0..] Pos[2] 1000
execute store result storage derailed:train new.din int 1 run scoreboard players get #d dr_temp
execute store result storage derailed:train new.dout int 1 run scoreboard players get #d dr_temp
scoreboard players operation #t dr_temp = #ty dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train arg.y int 1 run scoreboard players add #t dr_temp 200
function derailed:dev/track/_path with storage derailed:train arg
function derailed:track/_place_take with storage derailed:train arg

execute at @n[type=marker,tag=dr_end_on,distance=0..] run function derailed:track/_mark_next
