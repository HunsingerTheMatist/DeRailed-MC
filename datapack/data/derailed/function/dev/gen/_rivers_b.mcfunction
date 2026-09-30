
# Cuts a second river beside the first when the first came up short, allowed to
#  end in the first
# Positioned at the section's corner

function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_best,distance=0..]

# A first river as long as the pair is meant to be between them is the section's
#  whole river
execute if score #riv_first dr_var >= #gen_riv_pair dr_var run return run kill @e[type=marker,tag=dr_riv_seed,distance=0..]

# Otherwise a second sets out clear of where the first did and makes the pair up
#  to length between them, with a floor of its own so that it is never a puddle
scoreboard players operation #riv_col1 dr_var = #riv_col_got dr_var
scoreboard players operation #riv_need dr_var = #gen_riv_pair dr_var
scoreboard players operation #riv_need dr_var -= #riv_got dr_var
scoreboard players operation #riv_need dr_var > #gen_riv_2nd dr_var
function derailed:dev/gen/_river_one
scoreboard players operation #riv_second dr_var = #riv_got dr_var

execute if score #gen_riv_hold dr_var matches 1 run return 0
function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_best,distance=0..]
kill @e[type=marker,tag=dr_riv_seed,distance=0..]
