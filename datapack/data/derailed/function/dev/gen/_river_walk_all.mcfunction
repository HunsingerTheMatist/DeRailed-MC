
# Picks a paused river's walk up again until it is done
# Positioned at the section's corner

execute if score #riv_paused dr_var matches 1 run function derailed:dev/gen/_river_walk_on
execute if score #riv_paused dr_var matches 1 run function derailed:dev/gen/_river_walk_all
