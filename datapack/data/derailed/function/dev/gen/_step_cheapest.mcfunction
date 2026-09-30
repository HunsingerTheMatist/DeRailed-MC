
# Finds the cheapest way across once both routes have cut what they cut, and
#  holds the section to the tier's band by it
# Positioned at the section's corner

execute store result score #q_w dr_var run scoreboard players get #gen_valid dr_var
# The cheapest way across is what the band holds a section to, and it is the
#  first route unless the second cut rock, when it is found again over both
#  routes' cuts; a section whose cheapest way falls outside the band is a
#  reroll, cheaper once cut where it fell under the floor, which the first
#  route alone never does, and too expensive where it is over the ceiling
scoreboard players operation #true_cost dr_var = #gen_cost dr_var
scoreboard players operation #true_route dr_var = #gen_route dr_var
scoreboard players operation #true_rate dr_var = #gen_rate dr_var
execute if score #gen_valid dr_var matches 1 if score #sec_reached dr_var matches 1 if score #sec_carved dr_var matches 1.. positioned ~ ~15 ~ run function derailed:dev/gen/_cheapest
execute if score #gen_valid dr_var matches 1 if score #sec_reached dr_var matches 1 if score #sec_carved dr_var matches 0 if score #sec_opened dr_var matches 1.. positioned ~ ~15 ~ run function derailed:dev/gen/_cheapest
scoreboard players set #true_ok dr_var 0
execute if score #true_rate dr_var >= #gen_rate_min dr_var if score #true_rate dr_var <= #gen_rate_max dr_var run scoreboard players set #true_ok dr_var 1
execute if score #gen_rate_free dr_var matches 1 run scoreboard players set #true_ok dr_var 1
execute if score #gen_valid dr_var matches 1 if score #true_ok dr_var matches 0 if score #true_rate dr_var < #gen_rate_min dr_var run scoreboard players add #gen_fail_shortcut dr_var 1
execute if score #gen_valid dr_var matches 1 if score #true_ok dr_var matches 0 if score #true_rate dr_var > #gen_rate_max dr_var run scoreboard players add #gen_fail_costly dr_var 1
execute if score #true_ok dr_var matches 0 run scoreboard players set #gen_valid dr_var 0

scoreboard players set #q_step dr_var 14
return run scoreboard players get #q_w dr_var
