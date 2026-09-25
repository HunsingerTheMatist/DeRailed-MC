
# Leaves a note on each of the station's four tiles along the eastern edge for
#  the section after to read as ground, since the station reads as ground
#  across the seam and spreads as ground from there
# Takes the station's rows from 'r'
# Positioned at the section's corner

$execute positioned ~31 ~ ~$(top) run function derailed:dev/gen/_station_note
$execute positioned ~31 ~ ~$(exit) run function derailed:dev/gen/_station_note
$execute positioned ~31 ~ ~$(low) run function derailed:dev/gen/_station_note
$execute positioned ~31 ~ ~$(foot) run function derailed:dev/gen/_station_note
