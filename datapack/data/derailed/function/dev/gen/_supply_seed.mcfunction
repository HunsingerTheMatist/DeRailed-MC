
# Notes whether the flood got to this seed, and how many tiles of water lie on
#  the cheapest way from the route to it
# Run as the seed, positioned on its tile

tag @s remove dr_reach
tag @s remove dr_used
execute if score @s dr_kind matches 4 run return 0
execute unless block ~ ~2 ~ #derailed:flood_visited run return 0
tag @s add dr_reach

scoreboard players set #sup_mark dr_var 0
function derailed:dev/gen/_supply_trace
scoreboard players operation @s dr_bridge = #sup_new dr_var
