
# Walks the route back from the tile at column $(x), row $(z), keeping count of
#  the column and row it stands on so that the section's edges can be told

$scoreboard players set #trace_x dr_var $(x)
$scoreboard players set #trace_z dr_var $(z)
$execute positioned ~$(x) ~ ~$(z) run function derailed:dev/gen/_trace
