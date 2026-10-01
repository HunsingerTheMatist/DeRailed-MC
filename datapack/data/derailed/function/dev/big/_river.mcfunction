
# Tags this river tile's marker with the way its glaze on the river layer points,
#  'dr_big_n', 'dr_big_e', 'dr_big_s' or 'dr_big_w', or 'dr_big_cut' where it
#  has none, which is a cut through rock that runs as river
# Run as the tile's marker, on the tile

tag @s add dr_big_river
execute if block ~ ~-6 ~ magenta_glazed_terracotta[facing=north] run return run tag @s add dr_big_n
execute if block ~ ~-6 ~ magenta_glazed_terracotta[facing=east] run return run tag @s add dr_big_e
execute if block ~ ~-6 ~ magenta_glazed_terracotta[facing=south] run return run tag @s add dr_big_s
execute if block ~ ~-6 ~ magenta_glazed_terracotta[facing=west] run return run tag @s add dr_big_w
tag @s add dr_big_cut
