
# Sets the second river up where the first came up short, and returns 0 where
#  the first is the section's whole river
# Positioned at the section's corner

function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_best,distance=0..]

# A first river as long as the pair is meant to be between them is the section's
#  whole river
execute if score #riv_first dr_var >= #gen_riv_pair dr_var run kill @e[type=marker,tag=dr_riv_seed,distance=0..]
execute if score #riv_first dr_var >= #gen_riv_pair dr_var run return 0

# Otherwise a second sets out clear of where the first did and makes the pair up
#  to length between them, with a floor of its own so that it is never a puddle
scoreboard players operation #riv_col1 dr_var = #riv_col_got dr_var
scoreboard players operation #riv_need dr_var = #gen_riv_pair dr_var
scoreboard players operation #riv_need dr_var -= #riv_got dr_var
scoreboard players operation #riv_need dr_var > #gen_riv_2nd dr_var
return 1
