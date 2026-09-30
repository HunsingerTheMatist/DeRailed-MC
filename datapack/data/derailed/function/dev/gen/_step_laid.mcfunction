
# Sends the section on to its attempts once it is laid out: a first laying
#  keeps what the report counted of the section before's last columns before
#  any attempt counts this section's, and starts the fresh starts over too
# Held for a look at the river, a first laying stops here with nothing drawn
#  over it
# Positioned at the section's corner

execute if score #q_relay dr_var matches 1 run return run function derailed:dev/gen/_step_relaid
execute if score #gen_riv_hold dr_var matches 1 if score #gen_fresh dr_var matches 0 run return run function derailed:dev/gen/_step_close

# A few attempts on these regions, then the section is started afresh while
#  fresh starts are left
scoreboard players set #q_step dr_var 10
scoreboard players operation #gen_attempts dr_var = #gen_attempt_count dr_var
scoreboard players set #gen_second_misses dr_var 0
execute if score #gen_fresh dr_var matches 1 run return run scoreboard players set #gen_fresh dr_var 0
execute if score #gen_report dr_var matches 1 run function derailed:dev/gen/_rim_keep
scoreboard players operation #gen_fresh_left dr_var = #gen_fresh_max dr_var
return 1
