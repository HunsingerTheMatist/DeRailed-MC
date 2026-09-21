
# Starts the chain at the seed nearest where the track comes in
# Takes $(entry), the row the track enters on

$execute positioned ~ ~ ~$(entry) as @n[type=marker,tag=dr_seed,distance=..40] run function derailed:dev/gen/_join
