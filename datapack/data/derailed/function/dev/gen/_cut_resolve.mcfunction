
# Fills every run of cut rock in, one run at a time
# Positioned at the section's corner

scoreboard players set #cut_r dr_var 1
function derailed:dev/gen/_cut_run_next

scoreboard players operation #gen_carved dr_var += #cut_n dr_var
kill @e[type=marker,tag=dr_cut,distance=0..]
kill @e[type=marker,tag=dr_cut_run,distance=0..]
