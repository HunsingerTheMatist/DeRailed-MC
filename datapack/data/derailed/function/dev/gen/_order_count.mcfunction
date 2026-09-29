
# Counts this tile onto level $(w) in 'dr_ord': as wood, as iron, and as the
#  first route's track, twice where the track crosses water, once for the
#  bridge and once for the rail; keeps the furthest level the flood and the
#  first route reach; and brings the seed of the region the tile belongs to
#  down to this level in 'dr_olev', tagging it 'dr_ofirst' where the first
#  route runs over the tile
# Positioned on the tile, with the routes kept three above

$execute if block ~ ~ ~ brown_concrete run scoreboard players add #ow$(w) dr_ord 1
$execute if block ~ ~ ~ light_gray_concrete run scoreboard players add #oi$(w) dr_ord 1
$execute if block ~ ~3 ~ #derailed:first_route run scoreboard players add #or$(w) dr_ord 1
$execute if block ~ ~3 ~ #derailed:first_route if block ~ ~ ~ #derailed:cost_water run scoreboard players add #or$(w) dr_ord 1
execute if block ~ ~3 ~ #derailed:first_route run scoreboard players operation #ormax dr_var > #cost_wave dr_var
scoreboard players operation #omax dr_var > #cost_wave dr_var

function derailed:dev/gen/_read_owner
execute as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run scoreboard players operation @s dr_olev < #cost_wave dr_var
execute if block ~ ~3 ~ #derailed:first_route as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run tag @s add dr_ofirst
