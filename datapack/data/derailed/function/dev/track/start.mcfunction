# Starts the track on the tile the player stands on, the map's tiles three
#  blocks across from its corner at x1100 z0: a straight rail across it the way
#  they face, which is the end of the track, the only rail in
#  'derailed:track rails' and the whole of the path the train runs on, at the
#  height of the block they stand in; takes every train away first
# Run as a player in the game

function derailed:dev/train/clear
kill @e[type=marker,tag=dr_track_end,distance=0..]

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

execute summon marker run function derailed:dev/track/_end
scoreboard players operation #din dr_temp = #d dr_temp
scoreboard players operation #dout dr_temp = #d dr_temp
execute at @n[type=marker,tag=dr_track_end,distance=0..] positioned ~-1 ~ ~-1 run function derailed:track/lay_rails

data modify storage derailed:train new set value {x:0,z:0,din:0,dout:0,len:3000}
execute store result storage derailed:train new.x int 1 run data get entity @n[type=marker,tag=dr_track_end,distance=0..] Pos[0] 1000
execute store result storage derailed:train new.z int 1 run data get entity @n[type=marker,tag=dr_track_end,distance=0..] Pos[2] 1000
execute store result storage derailed:train new.din int 1 run scoreboard players get #d dr_temp
execute store result storage derailed:train new.dout int 1 run scoreboard players get #d dr_temp
data modify storage derailed:train path set value []
data modify storage derailed:train path append from storage derailed:train new
scoreboard players operation #t dr_temp = #ty dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train y int 1 run scoreboard players add #t dr_temp 200

data modify storage derailed:track rails set value []
data modify storage derailed:track rails append from entity @n[type=marker,tag=dr_track_end,distance=0..] Pos
