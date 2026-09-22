
# Cuts one river: a search from each of a handful of starts until one reaches
#  an exit, and failing all of them the longest line any of them managed, ending
#  in a lake
# Positioned at the section's corner, with '#riv_need' the length it has to
#  reach and '#riv_col1' the column the river before set out from

scoreboard players set #riv_done dr_var 0
scoreboard players set #riv_len dr_var 0
scoreboard players set #riv_dead dr_var 0
scoreboard players set #riv_depth dr_var 0
scoreboard players set #riv_best dr_var 0
scoreboard players set #riv_join dr_var 0

# What came of it, for the river after this one to keep clear of and to make
#  the pair up to length against
scoreboard players set #riv_got dr_var 0
scoreboard players set #riv_col_got dr_var -100

# Walks are cheap to start and dear to finish, so misses get their own budget and
#  the starts share one count of steps
scoreboard players set #riv_tries dr_var 5
scoreboard players set #riv_rolls dr_var 200
scoreboard players set #riv_steps dr_var 1500

function derailed:dev/gen/_river_try

# Nothing reached an exit from any start, so the longest line found on the way
#  is laid instead, or the section goes without
execute if score #riv_done dr_var matches 0 if score #riv_best dr_var matches 1.. run return run function derailed:dev/gen/_river_settle
execute if score #riv_done dr_var matches 0 run scoreboard players add #gen_no_river dr_var 1
