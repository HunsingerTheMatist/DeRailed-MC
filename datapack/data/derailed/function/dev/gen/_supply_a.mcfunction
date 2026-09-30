
# Starts the supply check: floods out from the first route, counts what the
#  flood reached, and sets the repair's search going; returns 0 where the track
#  never got across, with nothing left for the check to do
# Positioned at the section's corner, once both routes are found

scoreboard players set #sup_done dr_var 1
scoreboard players set #sup_short dr_var 0
scoreboard players set #gen_repainted dr_var 0
scoreboard players set #gen_spread_gaps dr_var 0
scoreboard players set #gen_spread_fail dr_var 0
scoreboard players set #gen_tail_gap dr_var 0
scoreboard players set #gen_repair_swaps dr_var 0
scoreboard players set #gen_repair_paints dr_var 0
scoreboard players set #gen_repair_left dr_var 0
scoreboard players set #rep_tw dr_var 0
scoreboard players set #rep_ti dr_var 0
scoreboard players set #sup_rock_n dr_var 0
scoreboard players set #sup_wall_n dr_var 0
scoreboard players set #sup_wood_n dr_var 0
scoreboard players set #sup_wood_r dr_var 0
scoreboard players set #sup_iron_n dr_var 0
scoreboard players set #sup_iron_r dr_var 0

# A section the track never got across has nothing within reach of it, which
#  is what the section after is told about its columns, held in 'sec_cols'
#  until the section ships
execute if score #gen_reached dr_var matches 0 run data modify storage derailed:gen sec_cols set value [{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0},{w:0,i:0}]
execute if score #gen_reached dr_var matches 0 run return 0

function derailed:dev/gen/_supply_base

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

# Which regions the first route runs through, since one of those is only ever
#  repainted from one resource to the other
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

# Puts the section's wood and iron right, where they are placed and how much of
#  them there is, by searching: the section is scored by how short every
#  window, the tail and the totals fall, every change it may make is scored the
#  same way, and the one that lowers the score most is made, until the score is
#  nothing or no change lowers it
# Every change only ever lowers the score, so the search cannot go round in
#  circles, and it changes no more than it has to; '_rep_step' takes the steps,
#  up to '#rep_steps' of them
scoreboard players set #rep_first dr_var 0
execute if score #gen_section dr_var matches 0 run scoreboard players set #rep_first dr_var 1
execute if score #rep_first dr_var matches 0 run function derailed:dev/gen/_rep_prev
scoreboard players operation #sp_need dr_var = #gen_spread_need dr_var

scoreboard players set #rep_steps dr_var 8
scoreboard players set #gen_repair_swaps dr_var 0
scoreboard players set #gen_repair_paints dr_var 0
return 1
