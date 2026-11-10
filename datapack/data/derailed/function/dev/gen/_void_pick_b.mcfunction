
# Picks '#void_b' anywhere in the column, again while it is within 3 rows of
#  '#void_a' or falls on the middle three of the start station's rows

execute store result score #void_b dr_var run random value 0..15 derailed:gen
scoreboard players operation #t dr_temp = #void_a dr_var
scoreboard players operation #t dr_temp -= #void_b dr_var
execute if score #t dr_temp matches -3..3 run return run function derailed:dev/gen/_void_pick_b
scoreboard players operation #t dr_temp = #void_b dr_var
scoreboard players operation #t dr_temp -= #gen_entry dr_var
execute if score #gen_station dr_var matches 1 if score #t dr_temp matches 0..2 run function derailed:dev/gen/_void_pick_b
