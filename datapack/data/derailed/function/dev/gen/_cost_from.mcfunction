
# Starts the least-cost flood on the tile the track comes in on
# Takes $(entry), the row the track enters on

$execute positioned ~ ~ ~$(entry) run function derailed:dev/gen/_cost_run
