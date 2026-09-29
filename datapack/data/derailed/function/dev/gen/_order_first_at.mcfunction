
# Tags 'dr_ofirst' the seed of the region under this tile where the first route
#  runs over it
# Positioned on the tile, with the routes kept three above

execute unless block ~ ~3 ~ #derailed:first_route run return 0
function derailed:dev/gen/_read_owner
execute as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run tag @s add dr_ofirst
