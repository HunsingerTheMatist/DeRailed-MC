
# Puts the section's wood and iron right, where they are placed and how much of
#  them there is, by searching: the section is scored by how short every
#  window, the tail and the totals fall, every change it may make is scored the
#  same way, and the one that lowers the score most is made, until the score is
#  nothing or no change lowers it
# Every change only ever lowers the score, so the search cannot go round in
#  circles, and it changes no more than it has to
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

scoreboard players set #rep_first dr_var 0
execute if score #gen_section dr_var matches 0 run scoreboard players set #rep_first dr_var 1
execute if score #rep_first dr_var matches 0 run function derailed:dev/gen/_rep_prev
scoreboard players operation #sp_need dr_var = #gen_spread_need dr_var

scoreboard players set #rep_steps dr_var 8
scoreboard players set #gen_repair_swaps dr_var 0
scoreboard players set #gen_repair_paints dr_var 0
function derailed:dev/gen/_rep_step

# What is left short once the search is done
function derailed:dev/gen/_rep_measure
scoreboard players operation #gen_repair_left dr_var = #rep_score dr_var
function derailed:dev/gen/_rep_totals
