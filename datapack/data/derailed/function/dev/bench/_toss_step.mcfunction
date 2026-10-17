# Moves every thrown pile a tick's worth, as 'toss/tick' does
# Run in the game's dimension

execute as @e[type=item_display,tag=dr_toss,distance=0..] at @s run function derailed:toss/_fly
