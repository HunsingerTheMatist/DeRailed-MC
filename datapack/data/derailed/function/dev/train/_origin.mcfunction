
# Takes the block this marker stands on as the track's northwestern corner, in
#  '#ox', '#oy' and '#oz', and the height the train runs at, 0.2 above it,
#  into the path's 'y'
# Run as a marker at the corner, which it removes

execute store result score #ox dr_temp run data get entity @s Pos[0]
execute store result score #oy dr_temp run data get entity @s Pos[1]
execute store result score #oz dr_temp run data get entity @s Pos[2]
kill @s
scoreboard players operation #t dr_temp = #oy dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train y int 1 run scoreboard players add #t dr_temp 200
