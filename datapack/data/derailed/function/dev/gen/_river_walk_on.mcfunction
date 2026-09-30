
# Picks a paused river's walk up again from its head, for another share of
#  steps, then goes on to the next start and to the end of the search, as the
#  walk would have, unless it pauses again
# Positioned at the section's corner

scoreboard players set #riv_paused dr_var 0
scoreboard players set #riv_slice dr_var 0
execute as @e[type=marker,tag=dr_riv_head,distance=0..] at @s run function derailed:dev/gen/_river_run
execute if score #riv_paused dr_var matches 0 if score #riv_done dr_var matches 0 run function derailed:dev/gen/_river_try
execute if score #riv_paused dr_var matches 0 run function derailed:dev/gen/_river_one_end
