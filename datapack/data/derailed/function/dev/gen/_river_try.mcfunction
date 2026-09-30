
# Picks where to set out from, and keeps picking until a river comes of one
# Positioned at the section's corner

scoreboard players remove #riv_rolls dr_var 1
execute if score #riv_rolls dr_var matches ..0 run return fail
execute if score #riv_tries dr_var matches ..0 run return fail
execute if score #riv_steps dr_var matches ..0 run return fail

# The border was picked once for the section, so both its rivers come in by it
execute if score #riv_from dr_var matches 0 run function derailed:dev/gen/_river_from_s
execute if score #riv_from dr_var matches 1 run function derailed:dev/gen/_river_from_n

execute if score #riv_done dr_var matches 0 if score #riv_paused dr_var matches 0 run function derailed:dev/gen/_river_try
