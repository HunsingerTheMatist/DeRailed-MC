# Moves every thrown pile on a tick
# Run in the game's dimension

execute as @e[type=item_display,tag=dr_toss,distance=0..] at @s run function derailed:toss/_fly
