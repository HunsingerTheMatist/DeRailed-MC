# Starts the player's team's track on the start station's seven rails, which
#  'dev/big/build' lays in the first section: lays them anew as the team's
#  track tiles, the seventh the end of the track, all seven the team's rails
#  and the path its train runs on, with the tiles the next rail could go on
#  marked and the take interactions on the seventh; takes the team's train away
#  first, and the end, next tiles, track tiles, rails and take interactions of
#  any track it had before, the station's excepted, and any track tile on no
#  team, the start station's own among them
# Run as a player in the game, on a team

scoreboard players operation #train_team dr_temp = @s dr_team
execute if score #train_team dr_temp matches 0 run return run tellraw @s "Join a team first, /team join dr_red or dr_blue"
execute unless entity @e[type=marker,tag=dr_station_start,distance=0..] run return run tellraw @s "Build the first section first, with dev/big/build and #big_section 0"
execute store result storage derailed:train arg.team int 1 run scoreboard players get #train_team dr_temp
function derailed:dev/train/clear with storage derailed:train arg
execute as @e[type=marker,tag=dr_track_end,distance=0..] if score @s dr_team = #train_team dr_temp run kill @s
execute as @e[type=marker,tag=dr_track_next,distance=0..] if score @s dr_team = #train_team dr_temp run kill @s
function derailed:dev/track/clear

# The end starts on the first rail's middle block, under the western tile of
#  the station's building, facing east, and steps a tile east for each rail
#  after it
tag @e[type=marker,tag=dr_end_on,distance=0..] remove dr_end_on
scoreboard players set #d dr_temp 1
execute at @n[type=marker,tag=dr_station_start,distance=0..] positioned ~-4.5 ~2.5 ~5.5 summon marker run function derailed:dev/track/_station_end
execute store result score #t dr_temp run data get entity @n[type=marker,tag=dr_end_on,distance=0..] Pos[1]
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train arg.y int 1 run scoreboard players add #t dr_temp 200
scoreboard players set #curve dr_temp 0
scoreboard players set #rail_n dr_temp 0
function derailed:dev/track/_station_rail

execute at @n[type=marker,tag=dr_end_on,distance=0..] run function derailed:track/_mark_next
function derailed:track/_place_take with storage derailed:train arg
