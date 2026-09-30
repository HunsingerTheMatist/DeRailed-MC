
# Finds the second way again over what it cut, where it had to cut through rock,
#  as the first route is, then sets the rounds that open it up going where it
#  pinches the train more than the tier allows
# Positioned at the section's corner, with the first route and its band and
#  zone three above

execute if score #gen_carved dr_var matches 1.. run scoreboard players add #gen_cuts2 dr_var 1
execute if score #gen_carved dr_var matches 1.. run function derailed:dev/gen/_second_find

function derailed:dev/gen/_second_refind_end
