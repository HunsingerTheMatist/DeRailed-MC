
# Ends the supply check: the totals counted against the need, the columns kept
#  for the section after, and what the check left cleared
# Positioned at the section's corner, while the supply check's flood is still
#  laid

# Short after all that is counted
function derailed:dev/gen/_supply_count
function derailed:dev/gen/_supply_need
scoreboard players set #sup_short dr_var 0
execute if score #sup_wood dr_var < #need_wood dr_var run scoreboard players set #sup_short dr_var 1
execute if score #sup_iron dr_var < #need_iron dr_var run scoreboard players set #sup_short dr_var 1

# What each of this section's columns holds within reach once it is done, for
#  the windows of the section after to count, held in 'sec_cols' until the
#  section ships
function derailed:dev/gen/_col_scan
data modify storage derailed:gen sec_cols set from storage derailed:gen cols

# The routes come back onto their layer, and what the check left goes
fill ~ ~2 ~ ~31 ~2 ~15 air strict
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~2 ~ strict filtered #derailed:routes
fill ~ ~3 ~ ~31 ~3 ~15 air strict
fill ~ ~5 ~ ~31 ~5 ~15 air replace cyan_stained_glass strict
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_reach
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_used
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_cand
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_in
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_on_first
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_untake
scoreboard players set #gen_reached dr_var 1
