
# Lays the rails of the tile $(x) $(z) blocks from the track's corner, coming
#  in going way $(din) and leaving going way $(dout), and adds it to the end of
#  the path

$scoreboard players set #tx dr_temp $(x)
$scoreboard players set #tz dr_temp $(z)
$scoreboard players set #din dr_temp $(din)
$scoreboard players set #dout dr_temp $(dout)
$execute positioned ~$(x) ~ ~$(z) run function derailed:track/lay_rails
function derailed:dev/train/_path_tile
