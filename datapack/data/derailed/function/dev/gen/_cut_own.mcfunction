
# Gives every cut tile still of no region the region of a tile next to it of
#  the same terrain, a pass at a time so that a whole run filled with one
#  terrain takes it from the end it opens onto, until none is left or passes
#  run out
# River is no region's, so a tile of it is left as it is
# Positioned at the section's corner

execute as @e[type=marker,tag=dr_cut,distance=0..] at @s if block ~ ~-2 ~ air unless block ~ ~ ~ light_blue_concrete run function derailed:dev/gen/_cut_own_at
scoreboard players remove #cut_own_left dr_var 1
execute if score #cut_own_left dr_var matches 1.. run function derailed:dev/gen/_cut_own
