
# Gives up a line that could be laid on no side without carving a prefab: it
#  is not a way out after all, so the search goes back to its last choice,
#  without keeping the line as the longest found
# Run as the head

scoreboard players set #riv_done dr_var 0
scoreboard players add #riv_refused dr_var 1
tag @e[type=marker,tag=dr_riv_keep,distance=0..] remove dr_riv_keep
tag @e[type=marker,tag=dr_riv_line,distance=0..] remove dr_riv_line
tag @e[type=marker,tag=dr_riv_end,distance=0..] remove dr_riv_end
scoreboard players set #riv_refusing dr_var 1
function derailed:dev/gen/_river_back
