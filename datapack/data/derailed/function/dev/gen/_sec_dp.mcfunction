
# Works out the cheapest way along the first route from its last tile to its
#  entry, a stretch at a time: walking a stretch costs nothing, so every tile
#  of it costs what reaching the stretch did, and from each stretch reached one
#  search off the route finds what reaching every later stretch by a detour
#  costs, a thousand for every rock tile it cuts and one for every tile it
#  runs; every tile a detour can end on holds in 'dr_best' the least a way to
#  it has cost, in 'dr_from' the stretch that way came from and in 'dr_via'
#  the way the tile the detour stepped onto it from lies
# The tile a stretch is joined at, the cheapest of its tiles and the nearest
#  the route's last tile of those, is tagged 'dr_rej'
# Leaves '#sec_found' at 1 where the entry's stretch can be reached at all
# Positioned at the section's corner

scoreboard players set #sec_inf dr_var 1000000000
scoreboard players set #sec_thousand dr_var 1000
tag @e[type=marker,tag=dr_rej,distance=0..] remove dr_rej
execute as @e[type=marker,tag=dr_rp,distance=0..] run scoreboard players operation @s dr_best = #sec_inf dr_var
execute as @e[type=marker,tag=dr_rp,distance=0..] run scoreboard players set @s dr_from -1
scoreboard players set @e[type=marker,tag=dr_rp,scores={dr_step=0},distance=0..] dr_best 0

scoreboard players set #sec_s dr_var 0
function derailed:dev/gen/_sec_dp_s

scoreboard players set #sec_found dr_var 0
execute as @e[type=marker,tag=dr_rej,distance=0..] if score @s dr_str = #sec_last dr_var run scoreboard players set #sec_found dr_var 1
