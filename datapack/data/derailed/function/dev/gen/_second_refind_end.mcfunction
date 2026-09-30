
# Sets the rounds that open the second way up going where it pinches the train
#  more than the tier allows

scoreboard players set #pinch_rounds dr_var 4
execute if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var > #gen_pinch_max dr_var run scoreboard players add #gen_relieved2 dr_var 1
