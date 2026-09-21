
# Carries the river's head one corner west
# Run as the head, positioned on it

scoreboard players set #riv_dir dr_var 1
tp @s ~-1 ~ ~
execute at @s run function derailed:dev/gen/_river_lay
