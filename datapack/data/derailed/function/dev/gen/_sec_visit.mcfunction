
# Steps the search onto this tile: a tile of the first route ends the detour
#  there, and any other the search has not reached yet is taken where it is
#  inside the section, may be walked or cut, and lies within
#  '#gen_detour_max' tiles, a rock tile a level further on
# Rock is cut only away from the first route: never beside it, where it is
#  what pinches it, never in the zone round its pinches, and never the station
# Positioned on the tile, with the flood's layer two above, the first route's
#  band and zone three above and the regions as they grew fifteen below

execute if block ~ ~2 ~ gray_stained_glass run return 0
execute if entity @n[type=marker,tag=dr_rp,distance=..0.4] run return run execute as @n[type=marker,tag=dr_rp,distance=..0.4] run function derailed:dev/gen/_sec_rejoin
execute if entity @n[type=marker,tag=dr_bq,distance=..0.4] run return 0
execute if block ~ ~-15 ~ obsidian run return 0
execute if block ~ ~1 ~ powered_rail run return 0
execute if block ~ ~1 ~ oak_fence run return 0

scoreboard players operation #sec_nd dr_var = #sec_d dr_var
scoreboard players add #sec_nd dr_var 1
execute if score #sec_nd dr_var > #gen_detour_max dr_var run return 0

scoreboard players operation #sec_nr dr_var = #sec_r dr_var
execute if block ~ ~ ~ gray_concrete if block ~ ~3 ~ #derailed:second_band run return 0
execute if block ~ ~ ~ gray_concrete if block ~ ~3 ~ #derailed:second_zone run return 0
execute if block ~ ~ ~ gray_concrete if block ~ ~-15 ~ #derailed:prefab run return 0
execute if block ~ ~ ~ gray_concrete run scoreboard players add #sec_nr dr_var 1

execute summon marker run function derailed:dev/gen/_sec_new
