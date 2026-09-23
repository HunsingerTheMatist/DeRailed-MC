
# Finds a row of the column that is not rock: a handful of rolls keeping the
#  one furthest from the row it is to stay clear of, the same lean the first
#  pick had, and failing those any row at all
# A column that is rock from end to end leaves the row where it was, and the
#  route cuts its way through

scoreboard players set #edge_best dr_var -1
scoreboard players set #gen_tries dr_var 8
function derailed:dev/gen/_edge_roll
execute if score #edge_best dr_var matches 0.. run return 0

scoreboard players set #gen_row dr_var 0
function derailed:dev/gen/_edge_scan
