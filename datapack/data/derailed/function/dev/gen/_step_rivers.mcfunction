
# Sets the first river up and walks it for a share of steps, going on to walk
#  it further on the ticks after where it pauses, then to its end
# Positioned at the section's corner

# A section whose rivers found nowhere to start goes on without them, counted
#  by the search, since nothing a reroll does can put a river into it
scoreboard players set #q_step dr_var 5
execute unless score #gen_rivers dr_var matches 1 run return 0

scoreboard players set #riv_slice dr_var 0
function derailed:dev/gen/_rivers_a_pre
function derailed:dev/gen/_river_one
scoreboard players set #q_river_ret dr_var 55
scoreboard players set #q_step dr_var 55
execute if score #riv_paused dr_var matches 1 run scoreboard players set #q_step dr_var 54
return 1
