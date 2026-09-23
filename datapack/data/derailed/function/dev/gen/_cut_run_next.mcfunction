
# Fills in run '#cut_r' and moves on to the next

function derailed:dev/gen/_cut_run
scoreboard players add #cut_r dr_var 1
execute if score #cut_r dr_var <= #cut_runs dr_var run function derailed:dev/gen/_cut_run_next
