
# Reads which region this tile belongs to into '#gen_id': the region a cut
#  gave it, kept two below, where it has one, and otherwise the region it grew
#  as, fifteen below
# Positioned on the tile, on the visible layer

scoreboard players set #gen_id dr_var -1
execute unless block ~ ~-2 ~ air positioned ~ ~-2 ~ run return run function derailed:dev/gen/_read_id
execute positioned ~ ~-15 ~ run function derailed:dev/gen/_read_id
