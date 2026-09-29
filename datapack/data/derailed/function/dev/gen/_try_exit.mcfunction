
# Rolls another exit row and keeps it if it sits further from the entry row

execute store result score #gen_roll dr_var run random value 0..15 derailed:gen

scoreboard players operation #gen_far dr_var = #gen_roll dr_var
scoreboard players operation #gen_far dr_var -= #gen_entry dr_var
execute if score #gen_far dr_var matches ..-1 run scoreboard players operation #gen_far dr_var *= $NegOne dr_const

# The row before the distance, since updating the distance first would stop the
#  row from matching
execute if score #gen_far dr_var > #gen_best dr_var run scoreboard players operation #gen_exit dr_var = #gen_roll dr_var
execute if score #gen_far dr_var > #gen_best dr_var run scoreboard players operation #gen_best dr_var = #gen_far dr_var
