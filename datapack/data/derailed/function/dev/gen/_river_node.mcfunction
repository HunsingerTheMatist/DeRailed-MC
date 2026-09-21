
# Leaves a note of the choice at this corner, so a spent branch can be picked up
#  from here rather than from the start
# What the note does not hold is which ways are still untried: a way that has
#  been tried has a tile standing on it, written off or not, so the world says so
# Run as the head, positioned on it

execute if entity @n[type=marker,tag=dr_riv_node,distance=..0.4] run return 0

scoreboard players add #riv_depth dr_var 1
execute summon marker run function derailed:dev/gen/_river_note
