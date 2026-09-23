
# The tile the track leaves on has been reached: the wave it would have been
#  taken on is what the cheapest way across costs

scoreboard players set #gen_reached dr_var 1
scoreboard players operation #gen_cost dr_var = #cost_w dr_var
