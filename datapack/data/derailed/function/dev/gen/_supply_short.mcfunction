
# Repaints a region as whichever resource is short, a round at a time, until
#  neither is or nothing is left to repaint
# The other resource goes first, any region of it whose tiles that resource
#  can spare; then ground, then water; never rock, a wall, a lake, or a region
#  the first route runs through, since that would change what the route was
#  judged to cost. One the second route runs through may be, and if it was
#  water the second route has fewer bridges for it
# Rock never comes up, since the flood never gets to a rock seed
# Positioned at the section's corner

function derailed:dev/gen/_supply_need
scoreboard players set #sup_want dr_var 0
execute if score #sup_iron dr_var < #need_iron dr_var run scoreboard players set #sup_want dr_var 2
execute if score #sup_wood dr_var < #need_wood dr_var run scoreboard players set #sup_want dr_var 1
execute if score #sup_want dr_var matches 0 run return 0
execute if score #sup_rounds dr_var matches ..0 run return fail
scoreboard players remove #sup_rounds dr_var 1

# What the other resource has and needs, for whether a region of it can be
#  spared
execute if score #sup_want dr_var matches 1 run scoreboard players operation #sup_o dr_var = #sup_iron dr_var
execute if score #sup_want dr_var matches 1 run scoreboard players operation #need_o dr_var = #need_iron dr_var
execute if score #sup_want dr_var matches 2 run scoreboard players operation #sup_o dr_var = #sup_wood dr_var
execute if score #sup_want dr_var matches 2 run scoreboard players operation #need_o dr_var = #need_wood dr_var
scoreboard players set #sup_other dr_var 3
scoreboard players operation #sup_other dr_var -= #sup_want dr_var

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_cand
execute as @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_wall,tag=!dr_lake,tag=!dr_on_first,distance=0..] if score @s dr_kind = #sup_other dr_var run function derailed:dev/gen/_supply_spare
execute unless entity @e[type=marker,tag=dr_cand,distance=0..] run tag @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_wall,tag=!dr_lake,tag=!dr_on_first,scores={dr_kind=0},distance=0..] add dr_cand
execute unless entity @e[type=marker,tag=dr_cand,distance=0..] run tag @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_wall,tag=!dr_lake,tag=!dr_on_first,scores={dr_kind=3},distance=0..] add dr_cand
execute unless entity @e[type=marker,tag=dr_cand,distance=0..] run return fail

execute as @e[type=marker,tag=dr_cand,distance=0..,sort=random,limit=1] run function derailed:dev/gen/_supply_repaint
function derailed:dev/gen/_supply_count
function derailed:dev/gen/_supply_short
