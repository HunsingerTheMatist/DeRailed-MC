# Makes this new marker the end of the track, at the middle of the block
#  '#tx' '#ty' '#tz'
# Run as the new marker

tag @s add dr_track_end
scoreboard players operation #t dr_temp = #tx dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result entity @s Pos[0] double 0.001 run scoreboard players add #t dr_temp 500
scoreboard players operation #t dr_temp = #ty dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result entity @s Pos[1] double 0.001 run scoreboard players add #t dr_temp 500
scoreboard players operation #t dr_temp = #tz dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result entity @s Pos[2] double 0.001 run scoreboard players add #t dr_temp 500
