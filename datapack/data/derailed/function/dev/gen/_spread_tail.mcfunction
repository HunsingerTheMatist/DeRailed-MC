
# Leaves '#gen_tail_gap' at 1 where the last fifteen columns of the section
#  hold fewer than '#gen_tail_need' wood tiles within reach of a route, or as
#  few iron tiles
# Positioned at the section's corner, while the supply check's flood is still
#  laid

function derailed:dev/gen/_col_scan
scoreboard players set #gen_tail_gap dr_var 0
execute if score #tail_w dr_var < #gen_tail_need dr_var run scoreboard players set #gen_tail_gap dr_var 1
execute if score #tail_i dr_var < #gen_tail_need dr_var run scoreboard players set #gen_tail_gap dr_var 1
