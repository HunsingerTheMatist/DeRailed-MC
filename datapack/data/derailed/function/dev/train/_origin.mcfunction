
# Takes the block this marker stands on as the track's northwestern corner, in
#  '#ox', '#oy' and '#oz'
# Run as a marker at the corner, which it removes

execute store result score #ox dr_temp run data get entity @s Pos[0]
execute store result score #oy dr_temp run data get entity @s Pos[1]
execute store result score #oz dr_temp run data get entity @s Pos[2]
kill @s
