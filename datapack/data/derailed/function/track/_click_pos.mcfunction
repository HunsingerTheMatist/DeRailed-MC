# Takes the block this new marker stands in across into '#cx' and '#cz', and
#  removes it

execute store result score #cx dr_temp run data get entity @s Pos[0]
execute store result score #cz dr_temp run data get entity @s Pos[2]
kill @s
