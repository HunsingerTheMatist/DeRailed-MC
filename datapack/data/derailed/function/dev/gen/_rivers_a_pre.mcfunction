
# Sets the first river up: the search's leftovers cleared, the layer it cuts
#  into copied, and the border both rivers come in by rolled
# Positioned at the section's corner

function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_best,distance=0..]
kill @e[type=marker,tag=dr_riv_seed,distance=0..]

# The rivers are cut into a copy of what they read, so nothing they lay can
#  change the answer to a later look
clone ~ ~5 ~ ~31 ~5 ~15 ~ ~9 ~ strict

# The border is rolled once, so the second river comes in beside the first
execute store result score #riv_from dr_var run random value 0..1 derailed:gen

# The first river has nothing to keep clear of
scoreboard players set #riv_col1 dr_var -100
scoreboard players operation #riv_need dr_var = #gen_riv_min dr_var
