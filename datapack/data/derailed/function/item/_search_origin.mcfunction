# Takes the block this new marker stands in into '#ox', '#oy' and '#oz', and
#  removes it

execute store result score #ox dr_temp run data get entity @s Pos[0]
execute store result score #oy dr_temp run data get entity @s Pos[1]
execute store result score #oz dr_temp run data get entity @s Pos[2]
kill @s
