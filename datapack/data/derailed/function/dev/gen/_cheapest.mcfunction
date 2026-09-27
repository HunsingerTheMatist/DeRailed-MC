
# Finds the cheapest way across the section as it stands once both routes have
#  cut what they cut, which can be cheaper than the first route where the
#  second cut its way through rock, into '#true_cost' over '#true_route' rails,
#  '#true_rate' a rail with the length counted and '#true_ok' at 1 where that
#  is inside the tier's band
# Positioned at the section's corner, with the routes drawn two above and the
#  layer above them clear

# The routes are kept aside a layer up while the flood has theirs
clone ~ ~2 ~ ~31 ~2 ~15 ~ ~3 ~ strict
fill ~ ~2 ~ ~31 ~2 ~15 air strict

# What the first route came to is put back afterwards, since the flood and the
#  sums both leave theirs in the same scores
scoreboard players operation #keep_cost dr_var = #gen_cost dr_var
scoreboard players operation #keep_route dr_var = #gen_route dr_var
scoreboard players operation #keep_rate_raw dr_var = #gen_rate_raw dr_var
scoreboard players operation #keep_rate dr_var = #gen_rate dr_var
scoreboard players operation #keep_reached dr_var = #gen_reached dr_var

fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~32 ~2 ~-1 ~32 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~32 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~32 ~2 ~16 gray_stained_glass replace air strict
function derailed:dev/gen/_mark_goal with storage derailed:gen r
function derailed:dev/gen/_cost_from with storage derailed:gen r

scoreboard players set #gen_route dr_var 0
scoreboard players set #true_steps dr_var 400
execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_cheapest_from with storage derailed:gen r
function derailed:dev/gen/_rate_calc

scoreboard players operation #true_cost dr_var = #gen_cost dr_var
scoreboard players operation #true_route dr_var = #gen_route dr_var
scoreboard players operation #true_rate dr_var = #gen_rate dr_var
scoreboard players set #true_ok dr_var 0
execute if score #true_rate dr_var >= #gen_rate_min dr_var if score #true_rate dr_var <= #gen_rate_max dr_var run scoreboard players set #true_ok dr_var 1
execute if score #gen_rate_free dr_var matches 1 run scoreboard players set #true_ok dr_var 1

scoreboard players operation #gen_cost dr_var = #keep_cost dr_var
scoreboard players operation #gen_route dr_var = #keep_route dr_var
scoreboard players operation #gen_rate_raw dr_var = #keep_rate_raw dr_var
scoreboard players operation #gen_rate dr_var = #keep_rate dr_var
scoreboard players operation #gen_reached dr_var = #keep_reached dr_var

fill ~ ~2 ~ ~31 ~2 ~15 air strict
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~2 ~ strict
fill ~ ~3 ~ ~31 ~3 ~15 air strict
