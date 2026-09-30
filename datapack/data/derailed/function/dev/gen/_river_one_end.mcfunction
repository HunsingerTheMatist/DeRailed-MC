
# Ends one river's search once no walk is left to take: where nothing reached
#  an exit from any start, the longest line found on the way is laid instead,
#  or the section goes without
# Positioned at the section's corner

execute if score #riv_done dr_var matches 0 if score #riv_best dr_var matches 1.. run return run function derailed:dev/gen/_river_settle
execute if score #riv_done dr_var matches 0 run scoreboard players add #gen_no_river dr_var 1
