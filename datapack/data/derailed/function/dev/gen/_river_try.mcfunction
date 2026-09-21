
# Picks where to set out from, and keeps picking until a river comes of one
# Positioned at the section's corner

scoreboard players remove #riv_rolls dr_var 1
execute if score #riv_rolls dr_var matches ..0 run return fail
execute if score #riv_tries dr_var matches ..0 run return fail
execute if score #riv_steps dr_var matches ..0 run return fail

# A crossing handed over by the section before has to be taken up, or the two
#  rivers meet at a corner each and only touch at the diagonal
execute if score #riv_carry dr_var matches 1 run return run function derailed:dev/gen/_river_carried

# Otherwise north or south, and west as well for the first section, which has no
#  neighbour for a river to have come from
# The roll gets a score of its own: a search clobbers anything it borrows, so
#  reading it back after one has run picks a second side at random
execute if score #gen_section dr_var matches 0 store result score #riv_from dr_var run random value 0..2
execute unless score #gen_section dr_var matches 0 store result score #riv_from dr_var run random value 0..1
execute if score #riv_from dr_var matches 0 run function derailed:dev/gen/_river_from_s
execute if score #riv_from dr_var matches 1 run function derailed:dev/gen/_river_from_n
execute if score #riv_from dr_var matches 2 run function derailed:dev/gen/_river_from_w

execute if score #riv_done dr_var matches 0 run function derailed:dev/gen/_river_try
