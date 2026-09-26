
# Checks that the section holds enough wood and iron within reach of the route
#  to lay it, and repaints a region as whichever is short until it does
# Each route needs a wood and an iron for every rail and a bridge for every tile
#  of water under it, and the section is held to the costlier of the two; what
#  is within reach is found by a flood from the first route, water costing one
#  for the bridge to it and rock never crossed, and regions are drawn on
#  cheapest first, each bridge on the way charged once
# Positioned at the section's corner, once both routes are found

scoreboard players set #gen_tail_gap dr_var 0
scoreboard players set #gen_repair_swaps dr_var 0
scoreboard players set #gen_repair_paints dr_var 0
scoreboard players set #gen_repair_left dr_var 0
scoreboard players set #sup_rock_n dr_var 0
scoreboard players set #sup_wall_n dr_var 0
scoreboard players set #sup_wood_n dr_var 0
scoreboard players set #sup_wood_r dr_var 0
scoreboard players set #sup_iron_n dr_var 0
scoreboard players set #sup_iron_r dr_var 0

# A section the track never got across has nothing within reach of it, which
#  is what the section after is told about its columns
execute if score #gen_reached dr_var matches 0 run data modify storage derailed:gen prev_cols set value [{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0}]
execute if score #gen_reached dr_var matches 0 run return 0

# What the routes need, the costlier of the two on each count
scoreboard players operation #need_wood_base dr_var = #gen_route dr_var
scoreboard players operation #need_iron_base dr_var = #gen_route dr_var
execute if score #gen_bridge dr_var matches 1 run scoreboard players operation #need_wood_base dr_var += #crit_wet dr_var
execute if score #gen_bridge dr_var matches 2 run scoreboard players operation #need_iron_base dr_var += #crit_wet dr_var
scoreboard players operation #sup_w2 dr_var = #sec_route dr_var
scoreboard players operation #sup_i2 dr_var = #sec_route dr_var
execute if score #gen_bridge dr_var matches 1 run scoreboard players operation #sup_w2 dr_var += #sec_wet dr_var
execute if score #gen_bridge dr_var matches 2 run scoreboard players operation #sup_i2 dr_var += #sec_wet dr_var
execute if score #sec_reached dr_var matches 1 run scoreboard players operation #need_wood_base dr_var > #sup_w2 dr_var
execute if score #sec_reached dr_var matches 1 run scoreboard players operation #need_iron_base dr_var > #sup_i2 dr_var

# The routes are kept aside a layer up while the flood has the route layer,
#  and the first route's tiles are where it sets out from
fill ~ ~3 ~ ~31 ~3 ~15 air strict
clone ~ ~2 ~ ~31 ~2 ~15 ~ ~3 ~ strict filtered #derailed:routes
fill ~ ~2 ~ ~31 ~2 ~15 air strict
fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~32 ~2 ~-1 ~32 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~32 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~32 ~2 ~16 gray_stained_glass replace air strict
data modify storage derailed:gen e.f set value "_supply_source_at"
function derailed:dev/gen/_each
scoreboard players set #cost_mode dr_var 2
function derailed:dev/gen/_supply_flood
scoreboard players set #cost_mode dr_var 0

# Which regions the first route runs through, since one of those is never
#  repainted
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_on_first
data modify storage derailed:gen e.f set value "_supply_route_at"
function derailed:dev/gen/_each

# Which seeds the flood got to, each with the water on the way to it
execute as @e[type=marker,tag=dr_seed,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_supply_seed
scoreboard players set #gen_repainted dr_var 0

# Counted for the report as the kinds were drawn, before anything is
#  repainted: the rock and how much of it is the wall, and the wood and iron
#  and how much of each the flood got to; a region carried over the seam has no
#  seed here and is not counted
execute store result score #sup_rock_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=4},distance=0..]
execute store result score #sup_wall_n dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_wall,scores={dr_kind=4},distance=0..]
execute store result score #sup_wood_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute store result score #sup_wood_r dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_reach,scores={dr_kind=1},distance=0..]
execute store result score #sup_iron_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]
execute store result score #sup_iron_r dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_reach,scores={dr_kind=2},distance=0..]

# Wood and iron have to come along at a steady rate as well as add up, counted
#  in tiles within reach column by column: every thirty-column window wants two
#  seeds' worth of each, the last fifteen columns one, so that the section
#  after has something on this side of every window it is judged by, and the
#  totals what the routes need; the repair swaps and repaints regions to get
#  there, from the regions of either kind within reach, which are marked for it
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_supply
execute as @e[type=marker,tag=dr_seed,tag=dr_reach,distance=0..] if score @s dr_kind matches 1..2 run tag @s add dr_supply
function derailed:dev/gen/_repair

# Then the tail and the windows are judged as the section ships, for the report
function derailed:dev/gen/_spread_tail
function derailed:dev/gen/_spread
scoreboard players operation #gen_tail_gaps dr_var += #gen_tail_gap dr_var
scoreboard players operation #gen_spread_total dr_var += #gen_spread_gaps dr_var

# Short after all that is counted, and the section ships as it is
function derailed:dev/gen/_supply_count
function derailed:dev/gen/_supply_need
scoreboard players set #sup_short dr_var 0
execute if score #sup_wood dr_var < #need_wood dr_var run scoreboard players set #sup_short dr_var 1
execute if score #sup_iron dr_var < #need_iron dr_var run scoreboard players set #sup_short dr_var 1
execute if score #sup_short dr_var matches 1 run scoreboard players add #gen_supply_short dr_var 1
scoreboard players operation #gen_repaints dr_var += #gen_repainted dr_var
scoreboard players operation #gen_repair_swaps_total dr_var += #gen_repair_swaps dr_var
scoreboard players operation #gen_repair_paints_total dr_var += #gen_repair_paints dr_var

# What each of this section's columns holds within reach once it is done, for
#  the windows of the section after to count
function derailed:dev/gen/_col_scan
data modify storage derailed:gen prev_cols set from storage derailed:gen cols

# The routes come back onto their layer, and what the check left goes
fill ~ ~2 ~ ~31 ~2 ~15 air strict
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~2 ~ strict filtered #derailed:routes
fill ~ ~3 ~ ~31 ~3 ~15 air strict
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_reach
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_used
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_cand
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_in
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_on_first
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_untake
scoreboard players set #gen_reached dr_var 1
