
# Stands the head back on the choice at the current depth and takes another way
#  from it, or steps back another choice if that one is spent
# Run as the head
# Looking and going are separate: going runs a whole search of its own, and a
#  search nested inside this one sets '#riv_has' for itself, so reading it back
#  afterwards would say the wrong thing about this choice

scoreboard players set #riv_has dr_var 0
execute as @e[type=marker,tag=dr_riv_node,distance=0..] if score @s dr_depth = #riv_depth dr_var run function derailed:dev/gen/_river_resume_look
execute if score #riv_has dr_var matches 1 run return run function derailed:dev/gen/_river_resume_go

# That choice is used up, so the note goes and the search steps back another one
execute as @e[type=marker,tag=dr_riv_node,distance=0..] if score @s dr_depth = #riv_depth dr_var run kill @s
scoreboard players remove #riv_depth dr_var 1
function derailed:dev/gen/_river_back
