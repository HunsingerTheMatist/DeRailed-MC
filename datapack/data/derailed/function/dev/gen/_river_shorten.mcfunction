
# Walks the line the search settled on and keeps only the corners the walk passes
#  through, then lays it and counts what it laid
# The line is marked out with 'dr_riv_line' beforehand

# Where a line doubles back, the corner it came from and the corner it came back
#  to end up next to each other with a whole loop of line between them. The walk
#  always goes to the corner the search reached latest, so it takes the step
#  across and the loop is left behind, which is what keeps the water one wide
#  through a bend the search made a lap of

# The corner the search set out from is the one tile it laid before it had gone
#  anywhere, so it is where the walk starts and it lays no water of its own
execute as @n[type=marker,tag=dr_riv_line,scores={dr_step=0},distance=0..] run scoreboard players operation #riv_dir dr_var = @s dr_dir
execute as @n[type=marker,tag=dr_riv_line,scores={dr_step=0},distance=0..] at @s run function derailed:dev/gen/_river_short

function derailed:dev/gen/_river_stamp

# What the river came to once its loops were cut, which is the length the pair
#  is reckoned by: the search's own count can run to three times it
execute store result score #riv_got dr_var if entity @e[type=marker,tag=dr_riv_keep,distance=0..]
