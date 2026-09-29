
# Checks that the players can get their wood in order, leaving '#order_ok' at 1
#  where they can: a flood from the entry counts each tile's level, the water
#  on the way to it, and the land at a level is only reached once the wood at
#  every level below it, with '#gen_order_allow' in hand, covers the bridges
#  to it and the first route's track below it, '#gen_order_pct' percent over;
#  the section passes where every tile of the first route is reached, by the
#  flood at all and at a level paid for, and the wood and iron reached cover
#  what the routes need
# Positioned at the section's corner, with the routes drawn two above and the
#  layer above them clear

# The routes are kept aside a layer up while the flood has theirs
clone ~ ~2 ~ ~31 ~2 ~15 ~ ~3 ~ strict
fill ~ ~2 ~ ~31 ~2 ~15 air strict
fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~32 ~2 ~-1 ~32 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~32 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~32 ~2 ~16 gray_stained_glass replace air strict

scoreboard players set #order_ran dr_var 1
scoreboard players reset * dr_ord
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_olev 999
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ofirst
scoreboard players set #omax dr_var 0
scoreboard players set #ormax dr_var 0
scoreboard players set #orn dr_var 0
function derailed:dev/gen/_order_source with storage derailed:gen r
scoreboard players set #order_on dr_var 1
scoreboard players set #cost_mode dr_var 2
function derailed:dev/gen/_supply_flood
scoreboard players set #cost_mode dr_var 0
scoreboard players set #order_on dr_var 0

# Level by level from the first, the wood and iron below it and the track below
#  it, until a level cannot be paid for, which leaves '#oL' at the last one
#  reached, or every level is
scoreboard players operation #oW dr_var = #gen_order_allow dr_var
scoreboard players set #oI dr_var 0
scoreboard players set #oR dr_var 0
scoreboard players set #oL dr_var -1
scoreboard players set #ok dr_var 1
execute if score #omax dr_var matches 1.. run function derailed:dev/gen/_order_step
execute if score #oL dr_var matches -1 store result storage derailed:gen o.p int 1 run scoreboard players get #omax dr_var
execute if score #oL dr_var matches -1 run function derailed:dev/gen/_order_add with storage derailed:gen o
execute if score #oL dr_var matches -1 run scoreboard players operation #oL dr_var = #omax dr_var

scoreboard players set #order_ok dr_var 1
execute if score #ormax dr_var > #oL dr_var run scoreboard players set #order_ok dr_var 0
execute if score #orn dr_var < #gen_route dr_var run scoreboard players set #order_ok dr_var 0
execute if score #oW dr_var < #need_wood dr_var run scoreboard players set #order_ok dr_var 0
execute if score #oI dr_var < #need_iron dr_var run scoreboard players set #order_ok dr_var 0

fill ~ ~2 ~ ~31 ~2 ~15 air strict
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~2 ~ strict
fill ~ ~3 ~ ~31 ~3 ~15 air strict

# The flood took the track across, as the supply's does
scoreboard players set #gen_reached dr_var 1
