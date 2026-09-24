
# Takes this region's tiles as supply if its kind is still short, charging the
#  bridges on the way to it and building them for whoever comes after
# Run as the seed, positioned on its tile

function derailed:dev/gen/_supply_need
execute if score @s dr_kind matches 1 if score #sup_wood dr_var >= #need_wood dr_var run return 0
execute if score @s dr_kind matches 2 if score #sup_iron dr_var >= #need_iron dr_var run return 0

scoreboard players set #sup_mark dr_var 1
function derailed:dev/gen/_supply_trace
scoreboard players operation #sup_bridges dr_var += #sup_new dr_var
execute if score @s dr_kind matches 1 run scoreboard players operation #sup_wood dr_var += @s dr_size
execute if score @s dr_kind matches 2 run scoreboard players operation #sup_iron dr_var += @s dr_size
tag @s add dr_used
