
# Opens a run of rock to be cut, remembering what stood on the route just
#  before it, which is the run's end on the exit side
# Positioned on the run's first tile

scoreboard players add #cut_runs dr_var 1
scoreboard players set #cut_open dr_var 1
scoreboard players set #cut_pos dr_var 0
execute summon marker run function derailed:dev/gen/_cut_run_marked
