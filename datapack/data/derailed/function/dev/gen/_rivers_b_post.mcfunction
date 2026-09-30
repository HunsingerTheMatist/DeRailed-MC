
# Takes what the second river came to and clears the search's leftovers
# Positioned at the section's corner

scoreboard players operation #riv_second dr_var = #riv_got dr_var

execute if score #gen_riv_hold dr_var matches 1 run return 0
function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_best,distance=0..]
kill @e[type=marker,tag=dr_riv_seed,distance=0..]
