
# Counts this cell into the run being measured and keeps the lowest and
#  highest place along it
# Run as the cell's marker

scoreboard players add #pe_n dr_var 1
scoreboard players operation #pe_lo dr_var < @s dr_wave
scoreboard players operation #pe_hi dr_var > @s dr_wave
