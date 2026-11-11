
# Puts the station's overhang back into this tile wherever the tile is air,
#  leaving every block that is the tile's own as it is
# It is done on a copy of the ground 64 blocks south: the station is placed
#  there where it stands, this tile's blocks are laid over it, all but its air,
#  and the tile's columns are copied back from the copy
# The station is the nearest marker tagged 'dr_station', which stands where the
#  station was placed from, mirrored east to west where it is also tagged
#  'dr_station_start'
# Positioned at the tile's northwestern block, two below the ground

fill ~ ~ ~64 ~2 ~27 ~66 air strict
execute as @n[type=marker,tag=dr_station,distance=0..] at @s if entity @s[tag=!dr_station_start] run place template derailed:station ~ ~ ~64 none none 1 0 strict
execute as @n[type=marker,tag=dr_station,distance=0..] at @s if entity @s[tag=dr_station_start] run place template derailed:station ~ ~ ~64 none front_back 1 0 strict
clone ~ ~ ~ ~2 ~27 ~2 ~ ~ ~64 strict masked
clone ~ ~ ~64 ~2 ~27 ~66 ~ ~ ~ strict
