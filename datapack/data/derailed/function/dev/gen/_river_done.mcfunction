
# The river is made, so every tile still standing becomes the line to lay
# Run as the head

scoreboard players set #riv_done dr_var 1

# A river leaving eastward hands its crossing corner to the next section
execute if score #riv_exit dr_var matches 3 run scoreboard players set #riv_hand dr_var 1
execute if score #riv_exit dr_var matches 3 store result score #riv_hand_row dr_var run data get entity @s Pos[2] 1

execute as @e[type=marker,tag=dr_riv_path,distance=0..] unless entity @s[tag=dr_riv_dead] run tag @s add dr_riv_line
function derailed:dev/gen/_river_shorten
function derailed:dev/gen/_river_show
