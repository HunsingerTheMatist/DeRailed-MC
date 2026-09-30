
# Walks a paused river a share of steps further, then goes on to the step
#  '#q_river_ret' names once its search is done
# Positioned at the section's corner

function derailed:dev/gen/_river_walk_on
execute unless score #riv_paused dr_var matches 1 run scoreboard players operation #q_step dr_var = #q_river_ret dr_var
return 1
