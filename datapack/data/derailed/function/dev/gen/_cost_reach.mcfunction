
# The last tile the track is laid on has been reached: the wave it would have
#  been taken on, a thousand for every level of rock cut through on the way, is
#  what the cheapest way across costs

scoreboard players set #gen_reached dr_var 1
scoreboard players operation #gen_cost dr_var = #cost_base dr_var
scoreboard players operation #gen_cost dr_var += #cost_w dr_var
