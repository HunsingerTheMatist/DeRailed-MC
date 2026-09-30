
# Picks a paused stretch-by-stretch search up again from the stretch it stopped
#  at, for another share of searches, then ends it unless it pauses again
# Positioned at the section's corner

scoreboard players set #sec_paused dr_var 0
scoreboard players set #sec_slice dr_var 0
function derailed:dev/gen/_sec_dp_s
execute if score #sec_paused dr_var matches 0 run function derailed:dev/gen/_sec_dp_end
