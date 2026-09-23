
# Rolls a row and keeps it if it is clear of rock and further from the row to
#  stay clear of than any kept so far

execute store result storage derailed:gen e.row int 1 run random value 0..15
function derailed:dev/gen/_edge_roll_try with storage derailed:gen e

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_tries dr_var matches 1.. run function derailed:dev/gen/_edge_roll
