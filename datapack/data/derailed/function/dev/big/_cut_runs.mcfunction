
# Works out which way run '#big_r' flows, then the runs after it

function derailed:dev/big/_cut_run
scoreboard players add #big_r dr_temp 1
execute if score #big_r dr_temp <= #big_run dr_temp run function derailed:dev/big/_cut_runs
