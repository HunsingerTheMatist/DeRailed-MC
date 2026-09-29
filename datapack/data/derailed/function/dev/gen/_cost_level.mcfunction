
# Moves the flood on to the rock it came up against: a level is worth a
#  thousand, and the tiles parked on the last one wake in the order they were
#  reached
# Levels go on as far as 24 tiles of rock in a row, a section's height and a
#  half, so that no crossing is given up for the rock being too deep

scoreboard players add #cost_level dr_var 1
scoreboard players add #cost_base dr_var 1000
scoreboard players set #cost_wave dr_var 0
scoreboard players operation #cost_waiting dr_var = #cost_next dr_var
scoreboard players set #cost_next dr_var 0
execute if score #cost_level dr_var matches ..24 run function derailed:dev/gen/_cost_wave
