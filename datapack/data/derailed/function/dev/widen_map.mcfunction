# Widens the map's limits, which the search for a spot for a pile stays inside,
#  to take in the blocks '#wx0' to '#wx1' across and '#wz0' to '#wz1' down,
#  with the search's 20 blocks round them, and 3 blocks up and down from
#  '#wy', so piles put down by a test there are put down as on the map;
#  'dev/big/build' sets the map's own again

scoreboard players remove #wx0 dr_temp 20
scoreboard players add #wx1 dr_temp 20
scoreboard players remove #wz0 dr_temp 20
scoreboard players add #wz1 dr_temp 20
scoreboard players operation $MapMinX dr_var < #wx0 dr_temp
scoreboard players operation $MapMaxX dr_var > #wx1 dr_temp
scoreboard players operation $MapMinZ dr_var < #wz0 dr_temp
scoreboard players operation $MapMaxZ dr_var > #wz1 dr_temp
scoreboard players operation #t dr_temp = #wy dr_temp
scoreboard players remove #t dr_temp 3
scoreboard players operation $MapMinY dr_var < #t dr_temp
scoreboard players add #t dr_temp 6
scoreboard players operation $MapMaxY dr_var > #t dr_temp
