
# Counts a second way not found, and leaves the band it was looked for in
#  a layer up to be looked at
# Positioned at the section's corner

execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_no_second dr_var 1

# Where no second way was found, the band it was looked for in is left a
#  layer up, to be looked at: the first route in red, its pinched cells in
#  gray, the band beside it in white, the no-cut zone in black and light gray
#  where the two meet
execute if score #gen_reached dr_var matches 0 run clone ~ ~3 ~ ~31 ~3 ~15 ~ ~4 ~ strict
