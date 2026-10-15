# Takes back off the placement here what a planned move aside added to it
# Run as the note of where it went, at it

scoreboard players operation #t dr_temp = @s dr_count
execute as @n[type=interaction,tag=dr_placement,distance=..0.01] run scoreboard players operation @s dr_count -= #t dr_temp
