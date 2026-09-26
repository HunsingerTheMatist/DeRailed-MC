
# Searches out the second way across round the first route's pinches, cuts
#  what it runs through, opens it up where it pinches the train more than the
#  tier allows, and counts it where none is found
# Positioned at the section's corner, with the first route and its band and
#  zone three above

scoreboard players set #cost_mode dr_var 1
function derailed:dev/gen/_sec_prepare
function derailed:dev/gen/_second_find

# A route that had to cut through rock is found again over what it cut, as
#  the first route is
execute if score #gen_carved dr_var matches 1.. run scoreboard players add #gen_cuts2 dr_var 1
execute if score #gen_carved dr_var matches 1.. run function derailed:dev/gen/_second_find

scoreboard players set #pinch_rounds dr_var 4
execute if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var > #gen_pinch_max dr_var run scoreboard players add #gen_relieved2 dr_var 1
execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_pinch_relieve
execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_no_second dr_var 1

# Where no second way was found, the band it was looked for in is left a
#  layer up, to be looked at: the first route in red, its pinched cells in
#  gray, the band beside it in white, the no-cut zone in black and light gray
#  where the two meet
execute if score #gen_reached dr_var matches 0 run clone ~ ~3 ~ ~31 ~3 ~15 ~ ~4 ~ strict
