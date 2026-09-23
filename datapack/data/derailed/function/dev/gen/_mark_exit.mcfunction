
# Tags the seed nearest where the track leaves, on the section's east edge
# Takes $(exit), the row the track leaves on

$execute positioned ~31 ~ ~$(exit) as @n[type=marker,tag=dr_seed,distance=..40] run tag @s add dr_exit
