
# Marks the seed of the region under this tile as having the first route run
#  through it
# Positioned on the tile, with the routes kept three above and the regions as
#  they grew fifteen below

execute unless block ~ ~3 ~ #derailed:first_route run return 0
scoreboard players set #gen_id dr_var -1
execute positioned ~ ~-15 ~ run function derailed:dev/gen/_read_id
execute as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run tag @s add dr_on_first
