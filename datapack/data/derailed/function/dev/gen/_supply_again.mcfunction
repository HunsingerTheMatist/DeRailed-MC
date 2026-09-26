
# Goes through the regions not yet taken again, cheapest first, while either
#  kind is still short and passes are left
# Positioned at the section's corner

execute if score #sup_pass dr_var matches ..0 run return 0
function derailed:dev/gen/_supply_need
scoreboard players set #sup_again dr_var 0
execute if score #sup_wood dr_var < #need_wood dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_used,scores={dr_kind=1,dr_bridge=..8},distance=0..] run scoreboard players set #sup_again dr_var 1
execute if score #sup_iron dr_var < #need_iron dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_used,scores={dr_kind=2,dr_bridge=..8},distance=0..] run scoreboard players set #sup_again dr_var 1
execute if score #sup_again dr_var matches 0 run return 0

scoreboard players remove #sup_pass dr_var 1
scoreboard players set #sup_k dr_var 0
function derailed:dev/gen/_supply_round
function derailed:dev/gen/_supply_again
