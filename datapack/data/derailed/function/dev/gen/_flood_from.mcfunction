
# Starts the flood on the tile the track comes in on
# Takes $(entry), the row the track enters on

scoreboard players set #gen_from dr_var 0
$execute positioned ~ ~ ~$(entry) run function derailed:dev/gen/_flood
