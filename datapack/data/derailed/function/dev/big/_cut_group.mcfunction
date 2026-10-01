
# Starts a new run from this cut tile where it is in none yet
# Run as the tile's marker, at it

execute unless score @s dr_brun matches 0 run return 0
scoreboard players add #big_run dr_temp 1
function derailed:dev/big/_cut_spread
