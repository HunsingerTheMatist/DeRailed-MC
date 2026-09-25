
# Judges the box standing on the track's last rail and the station's first,
#  which the train runs on from the route onto: from the station's rail at
#  column $(x), row $(z), with the last rail lying the way $(back) points
# Positioned at the section's corner

$scoreboard players set #trace_x dr_var $(x)
$scoreboard players set #trace_z dr_var $(z)
$scoreboard players set #gen_back dr_var $(back)
$execute positioned ~$(x) ~ ~$(z) run function derailed:dev/gen/_pinch_pair
