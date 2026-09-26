
# Goes through the regions not yet taken again, cheapest first, while either
#  kind is still short with a region of it left to take, and the pass before
#  took something
# Positioned at the section's corner

function derailed:dev/gen/_supply_need
scoreboard players set #sup_again dr_var 0
execute if score #sup_wood dr_var < #need_wood dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_used,scores={dr_kind=1,dr_bridge=..8},distance=0..] run scoreboard players set #sup_again dr_var 1
execute if score #sup_iron dr_var < #need_iron dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_used,scores={dr_kind=2,dr_bridge=..8},distance=0..] run scoreboard players set #sup_again dr_var 1
execute if score #sup_again dr_var matches 0 run return 0

execute store result score #sup_took dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_used,distance=0..]
scoreboard players set #sup_k dr_var 0
function derailed:dev/gen/_supply_round
execute store result score #sup_took_now dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_used,distance=0..]
execute if score #sup_took_now dr_var > #sup_took dr_var run function derailed:dev/gen/_supply_again
