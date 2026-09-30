
# Measures the first route again where it had to cut through rock, then sets the
#  rounds that open it up going
# Positioned at the section's corner

# A route that had to cut through rock is measured again over what it cut,
#  since that is the route the players will have; the cut is rock free, so the
#  second pass cuts nothing
execute if score #gen_carved dr_var matches 1.. run scoreboard players add #gen_cuts dr_var 1
execute if score #gen_carved dr_var matches 1.. run function derailed:dev/gen/_validate_pass

# A route that pinches the train more than the tier allows is opened up rather
#  than thrown away, the rock beside its worst run cut back until it passes
scoreboard players set #gen_opened dr_var 0
scoreboard players set #pinch_rounds dr_var 4
execute if score #gen_pinch dr_var > #gen_pinch_max dr_var run scoreboard players add #gen_relieved dr_var 1
