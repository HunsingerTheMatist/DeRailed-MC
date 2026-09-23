
# Cuts a river along the boundaries between regions, in from one border and out
#  by the other, and a second beside it when the first came up short, allowed to
#  end in the first
# Positioned at the section's corner

function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_best,distance=0..]
kill @e[type=marker,tag=dr_riv_seed,distance=0..]

# The rivers are cut into a copy of what they read, so nothing they lay can
#  change the answer to a later look
clone ~ ~5 ~ ~31 ~5 ~15 ~ ~9 ~ strict

# The border is rolled once, so the second river comes in beside the first
execute store result score #riv_from dr_var run random value 0..1

# The first river has nothing to keep clear of
scoreboard players set #riv_col1 dr_var -100
scoreboard players operation #riv_need dr_var = #gen_riv_min dr_var
function derailed:dev/gen/_river_one
scoreboard players operation #riv_first dr_var = #riv_got dr_var
scoreboard players set #riv_second dr_var 0

# The search leaves its markers standing whether it got anywhere or not
# Holding them leaves the corners the walk ran over there to be read, which the
#  water cannot be read back as: a corner and the tile it wets are not the same
#  place
execute if score #gen_riv_hold dr_var matches 1 run return 0
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
