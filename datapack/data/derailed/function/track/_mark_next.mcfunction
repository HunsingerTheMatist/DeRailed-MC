# Marks each tile beside the end of the track the next rail could go on, any
#  but the one the track came in from and none that is a track tile, with a
#  marker tagged 'dr_track_next' in the middle of its middle block, facing the
#  way on to it
# Run at the middle of the end of the track's middle block

kill @e[type=marker,tag=dr_track_next,distance=0..]
execute store result score #back dr_temp run data get storage derailed:train path[-1].din
scoreboard players add #back dr_temp 2
scoreboard players operation #back dr_temp %= $Four dr_const

execute unless score #back dr_temp matches 0 positioned ~ ~ ~-3 unless entity @e[type=marker,tag=dr_track_tile,distance=..0.5] run summon marker ~ ~ ~ {Tags:["dr_track_next"],Rotation:[180f,0f]}
execute unless score #back dr_temp matches 1 positioned ~3 ~ ~ unless entity @e[type=marker,tag=dr_track_tile,distance=..0.5] run summon marker ~ ~ ~ {Tags:["dr_track_next"],Rotation:[270f,0f]}
execute unless score #back dr_temp matches 2 positioned ~ ~ ~3 unless entity @e[type=marker,tag=dr_track_tile,distance=..0.5] run summon marker ~ ~ ~ {Tags:["dr_track_next"],Rotation:[0f,0f]}
execute unless score #back dr_temp matches 3 positioned ~-3 ~ ~ unless entity @e[type=marker,tag=dr_track_tile,distance=..0.5] run summon marker ~ ~ ~ {Tags:["dr_track_next"],Rotation:[90f,0f]}
