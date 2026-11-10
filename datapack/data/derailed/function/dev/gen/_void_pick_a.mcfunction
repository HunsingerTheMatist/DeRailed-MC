
# Picks '#void_a' anywhere in the column, again while it falls on the middle
#  three of the start station's rows, its rail row and the two below

execute store result score #void_a dr_var run random value 0..15 derailed:gen
scoreboard players operation #t dr_temp = #void_a dr_var
scoreboard players operation #t dr_temp -= #gen_entry dr_var
execute if score #gen_station dr_var matches 1 if score #t dr_temp matches 0..2 run function derailed:dev/gen/_void_pick_a
