
# Starts a fresh map at the test area

scoreboard players set #gen_origin_x dr_var 1000
scoreboard players set #gen_section dr_var 0

function derailed:dev/gen/clear

# A run left over from last time would have the first section carrying regions in
#  from a map that is no longer there
kill @e[type=marker,tag=dr_edge,distance=0..]
kill @e[type=marker,tag=dr_prev_seed,distance=0..]
kill @e[type=marker,tag=dr_seam_wait,distance=0..]
function derailed:dev/gen/_kill_waves
kill @e[type=marker,tag=dr_riv_path,distance=0..]
kill @e[type=marker,tag=dr_riv_node,distance=0..]
kill @e[type=marker,tag=dr_riv_head,distance=0..]
kill @e[type=marker,tag=dr_riv_seed,distance=0..]
kill @e[type=armor_stand,tag=dr_seed_mark,distance=0..]

# The first section has to come in somewhere, so it comes in at the middle
scoreboard players set #gen_entry dr_var 8

scoreboard players set #gen_rerolls dr_var 0
scoreboard players set #gen_failed dr_var 0
scoreboard players set #gen_fail_path dr_var 0
scoreboard players set #gen_fail_supply dr_var 0
scoreboard players set #gen_no_river dr_var 0
scoreboard players set #riv_no_join dr_var 0
scoreboard players set #riv_joins dr_var 0
scoreboard players set #riv_lakes dr_var 0
scoreboard players set #riv_cuts dr_var 0
scoreboard players set #riv_extra dr_var 0
scoreboard players set #riv_dry dr_var 0

# Nothing to carry into the first section of a fresh run
scoreboard players set #riv_hand dr_var 0

