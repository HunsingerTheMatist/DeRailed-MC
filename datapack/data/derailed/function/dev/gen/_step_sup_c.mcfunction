
# Ends the supply's repair and judges the windows, then counts the totals on
#  the tick after
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_supply_c
scoreboard players set #q_step dr_var 37
return 1
