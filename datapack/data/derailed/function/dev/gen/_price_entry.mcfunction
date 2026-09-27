
# Takes what the tile the track comes in on costs back off both routes, since
#  the track already stands on it
# Takes $(entry), the row the track enters on
# Positioned at the section's corner

$execute positioned ~ ~ ~$(entry) run function derailed:dev/gen/_price_tile
scoreboard players operation #price_first dr_var -= #price_c dr_var
scoreboard players operation #price_second dr_var -= #price_c dr_var
