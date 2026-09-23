
# Walks the route back from the tile the track leaves on, keeping count of the
#  column and row it stands on so that the section's edges can be told
# Takes $(exit), the row the track leaves on

scoreboard players set #trace_x dr_var 31
$scoreboard players set #trace_z dr_var $(exit)
$execute positioned ~31 ~ ~$(exit) run function derailed:dev/gen/_trace
