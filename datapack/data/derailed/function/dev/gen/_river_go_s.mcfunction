
# Carries the river's head one corner south
# Run as the head, positioned on it

scoreboard players set #riv_dir dr_var 0
tp @s ~ ~ ~1
execute at @s run function derailed:dev/gen/_river_lay
