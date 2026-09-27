
# Charges the bridges on the way from the route to this piece and builds them
#  for whoever comes after, or drops the piece where the flood never got to it,
#  tagging it 'dr_dropped' and counting it onto '#piece_lost'
# Run as the piece's marker, positioned on its tile, with the flood's marks two
#  above and the bridges five above

execute unless block ~ ~2 ~ #derailed:flood_visited run tag @s add dr_dropped
execute unless block ~ ~2 ~ #derailed:flood_visited run return run scoreboard players add #piece_lost dr_var 1
scoreboard players set #sup_mark dr_var 1
function derailed:dev/gen/_supply_trace
scoreboard players operation #sup_bridges dr_var += #sup_new dr_var
