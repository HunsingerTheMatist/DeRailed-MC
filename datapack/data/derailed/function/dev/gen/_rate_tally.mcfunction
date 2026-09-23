
# Adds what the route just found costs a rail to the running figures the report
#  gives

scoreboard players add #gen_rate_n dr_var 1
scoreboard players operation #gen_rate_sum dr_var += #gen_rate dr_var
scoreboard players operation #gen_rate_lo dr_var < #gen_rate dr_var
scoreboard players operation #gen_rate_hi dr_var > #gen_rate dr_var
