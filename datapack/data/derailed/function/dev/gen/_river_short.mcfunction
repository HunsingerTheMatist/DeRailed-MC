
# Walks the line the search settled on, corner by corner, cutting out whatever it
#  looped around
# Run as the tile standing at this corner, positioned on it, with '#riv_dir' the
#  way the walk arrived

# A corner the shortcut comes at from a new direction wants the way it was really
#  reached, since that is what points the glaze where the search is being looked
#  at
scoreboard players operation @s dr_dir = #riv_dir dr_var
tag @s add dr_riv_keep

# Of the four corners next to this one, whichever the search reached latest, which
#  is the furthest along the line
# Nothing else is asked of the step: the two corners are one apart and both stand
#  on the line, so going straight between them is the river taking the near way
#  round whatever it looped through
# Starting from this corner's own reckoning is what keeps the walk going forward,
#  since the corner it came from is always behind it
scoreboard players operation #riv_far dr_var = @s dr_step
scoreboard players set #riv_bdir dr_var 0

scoreboard players set #riv_try dr_var 0
execute positioned ~ ~ ~1 as @n[type=marker,tag=dr_riv_line,distance=..0.4] run function derailed:dev/gen/_river_short_see

scoreboard players set #riv_try dr_var 1
execute positioned ~-1 ~ ~ as @n[type=marker,tag=dr_riv_line,distance=..0.4] run function derailed:dev/gen/_river_short_see

scoreboard players set #riv_try dr_var 2
execute positioned ~ ~ ~-1 as @n[type=marker,tag=dr_riv_line,distance=..0.4] run function derailed:dev/gen/_river_short_see

scoreboard players set #riv_try dr_var 3
execute positioned ~1 ~ ~ as @n[type=marker,tag=dr_riv_line,distance=..0.4] run function derailed:dev/gen/_river_short_see

# Going to a corner more than one step on is a loop being cut, which is counted
#  so that the report says how much of the line the walk took out
scoreboard players operation #riv_gap dr_var = #riv_far dr_var
scoreboard players operation #riv_gap dr_var -= @s dr_step
execute if score #riv_gap dr_var matches 2.. run scoreboard players add #riv_cuts dr_var 1

# Nothing further along means this corner is the end of the line, which is marked
#  so that a river with nowhere left to go knows where it ran out
execute unless score #riv_far dr_var > @s dr_step run return run tag @s add dr_riv_end

scoreboard players operation #riv_dir dr_var = #riv_bdir dr_var
function derailed:dev/gen/_river_short_go
