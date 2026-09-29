
# Rolls a row and keeps it if it is clear of rock and further from the row to
#  stay clear of than any kept so far, from the rows a station fits on, 1 to
#  13, as the route picks its rows from

execute store result storage derailed:gen e.row int 1 run random value 1..13 derailed:gen
function derailed:dev/gen/_edge_roll_try with storage derailed:gen e

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_tries dr_var matches 1.. run function derailed:dev/gen/_edge_roll
