
# Stands the head on the choice at the current depth and takes another way from it
# The reckoning of what is open was left ready by 'dev/gen/_river_resume_look'

execute as @e[type=marker,tag=dr_riv_node,distance=0..] if score @s dr_depth = #riv_depth dr_var at @s as @e[type=marker,tag=dr_riv_head,distance=0..] run function derailed:dev/gen/_river_retake
