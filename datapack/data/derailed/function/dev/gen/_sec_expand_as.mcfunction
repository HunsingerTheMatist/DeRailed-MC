
# Spreads the search from this tile, with what it cost to reach
# Run as the tile's marker, positioned on it

tag @s add dr_bdone
scoreboard players operation #sec_d dr_var = @s dr_depth
scoreboard players operation #sec_r dr_var = @s dr_rock
function derailed:dev/gen/_sec_expand
