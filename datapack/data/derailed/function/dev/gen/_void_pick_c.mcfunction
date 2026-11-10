
# Picks '#void_c' anywhere in the column, again while it is within 3 rows of
#  '#void_a' or '#void_b', falls on the middle three of the start station's
#  rows, or leaves all three on one side of the station

execute store result score #void_c dr_var run random value 0..15 derailed:gen
scoreboard players operation #t dr_temp = #void_a dr_var
scoreboard players operation #t dr_temp -= #void_c dr_var
execute if score #t dr_temp matches -3..3 run return run function derailed:dev/gen/_void_pick_c
scoreboard players operation #t dr_temp = #void_b dr_var
scoreboard players operation #t dr_temp -= #void_c dr_var
execute if score #t dr_temp matches -3..3 run return run function derailed:dev/gen/_void_pick_c
execute unless score #gen_station dr_var matches 1 run return 0
scoreboard players operation #t dr_temp = #void_c dr_var
scoreboard players operation #t dr_temp -= #gen_entry dr_var
execute if score #t dr_temp matches 0..2 run return run function derailed:dev/gen/_void_pick_c

# How many of the three are south of the station
scoreboard players set #t dr_temp 0
execute if score #void_a dr_var > #gen_entry dr_var run scoreboard players add #t dr_temp 1
execute if score #void_b dr_var > #gen_entry dr_var run scoreboard players add #t dr_temp 1
execute if score #void_c dr_var > #gen_entry dr_var run scoreboard players add #t dr_temp 1
execute unless score #t dr_temp matches 1..2 run function derailed:dev/gen/_void_pick_c
