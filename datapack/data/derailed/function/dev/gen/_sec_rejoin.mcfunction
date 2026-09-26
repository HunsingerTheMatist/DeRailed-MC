
# Ends a detour on this tile of the first route, where it is in a later stretch
#  than the one searched from, and keeps the detour as the way to it where it
#  is the cheapest yet: the rock cut, a thousand a tile, and the tiles run, on
#  top of what reaching the stretch searched from cost
# Run as the tile's marker, with '#sec_d' and '#sec_r' what reaching the tile
#  the detour steps onto this one from cost, and '#sec_back' the way that tile
#  lies from this one

execute unless score @s dr_str > #sec_s dr_var run return 0

scoreboard players operation #sec_c dr_var = #sec_r dr_var
scoreboard players operation #sec_c dr_var *= #sec_thousand dr_var
scoreboard players operation #sec_c dr_var += #sec_d dr_var
scoreboard players operation #sec_c dr_var += #sec_bs dr_var
execute unless score #sec_c dr_var < @s dr_best run return 0

scoreboard players operation @s dr_best = #sec_c dr_var
scoreboard players operation @s dr_from = #sec_s dr_var
scoreboard players operation @s dr_via = #sec_back dr_var
