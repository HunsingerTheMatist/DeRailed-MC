
# Walks the rows of the column from the top and takes the first that is not
#  rock

execute store result storage derailed:gen e.row int 1 run scoreboard players get #gen_row dr_var
execute store success score #edge_found dr_var run function derailed:dev/gen/_edge_scan_try with storage derailed:gen e
execute if score #edge_found dr_var matches 1 run return 0

scoreboard players add #gen_row dr_var 1
execute if score #gen_row dr_var matches ..15 run function derailed:dev/gen/_edge_scan
