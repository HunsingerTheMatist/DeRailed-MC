
# Searches off the route from every tile tagged 'dr_src' at once, out to
#  '#gen_detour_max' tiles, and gives every tile of a later stretch the search
#  gets back to the cost of that detour on top of '#sec_bs', where it is the
#  cheapest yet
# It takes the tiles it can reach cutting no rock first, then those one rock
#  tile further, and so on, each level nearest first, so that every tile is
#  reached once, by the way that cuts the least rock and then runs the fewest
#  tiles, and the way back from any tile never goes round in a circle
# Each tile the search reaches keeps a marker, 'dr_bq', with the rock cut to
#  reach it, 'dr_rock', and the tiles run, 'dr_depth', and the way the tile it
#  was reached from lies four above it, in the glass a flood leaves for it
# Positioned at the section's corner

scoreboard players add #gen_searches dr_var 1
scoreboard players add #sec_slice dr_var 1
kill @e[type=marker,tag=dr_bq,distance=0..]
fill ~ ~4 ~ ~31 ~4 ~15 air strict
scoreboard players set #sec_d dr_var 0
scoreboard players set #sec_r dr_var 0
execute as @e[type=marker,tag=dr_src,distance=0..] at @s run function derailed:dev/gen/_sec_expand

scoreboard players set #sec_lvl dr_var 0
scoreboard players set #sec_rd dr_var 1
function derailed:dev/gen/_sec_round
