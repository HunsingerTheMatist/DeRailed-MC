
# Records where the section's corner is, then removes the marker used to read it

execute store result score #gen_cx dr_var run data get entity @s Pos[0]
execute store result score #gen_cz dr_var run data get entity @s Pos[2]
kill @s
