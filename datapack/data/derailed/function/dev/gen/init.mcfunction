
# Starts a fresh map at the test area
# Moves itself into the game's dimension, so it is safe to call from anywhere

execute unless dimension derailed:game run return run execute in derailed:game run function derailed:dev/gen/init

scoreboard players set #gen_origin_x dr_var 1000
scoreboard players set #gen_section dr_var 0

function derailed:dev/gen/clear

# A run left over from last time would have the first section carrying regions in
#  from a map that is no longer there
kill @e[type=marker,tag=dr_edge,distance=0..]
kill @e[type=marker,tag=dr_edge_kept,distance=0..]
kill @e[type=marker,tag=dr_prev_seed,distance=0..]
kill @e[type=marker,tag=dr_seam_wait,distance=0..]
function derailed:dev/gen/_kill_waves
kill @e[type=marker,tag=dr_riv_path,distance=0..]
kill @e[type=marker,tag=dr_riv_node,distance=0..]
kill @e[type=marker,tag=dr_riv_head,distance=0..]
kill @e[type=marker,tag=dr_riv_best,distance=0..]
kill @e[type=marker,tag=dr_riv_seed,distance=0..]
kill @e[type=marker,tag=dr_flood,distance=0..]
kill @e[type=marker,tag=dr_cut,distance=0..]
kill @e[type=marker,tag=dr_cut_run,distance=0..]
kill @e[type=marker,tag=dr_pinch,distance=0..]
kill @e[type=armor_stand,tag=dr_seed_mark,distance=0..]
kill @e[type=marker,tag=dr_seed,distance=0..]
kill @e[type=marker,tag=dr_piece,distance=0..]
kill @e[type=marker,tag=dr_cp,distance=0..]
kill @e[type=marker,tag=dr_wq,distance=0..]
kill @e[type=marker,tag=dr_bq,distance=0..]
kill @e[type=marker,tag=dr_rp,distance=0..]
kill @e[type=marker,tag=dr_riv_keep,distance=0..]

# A build that stopped part way through a fresh start would leave the scatter
#  sparing the seeds it should retire
scoreboard players set #gen_fresh dr_var 0

# The first section has to come in somewhere, so it comes in at the middle
scoreboard players set #gen_entry dr_var 8

scoreboard players set #gen_rerolls dr_var 0
scoreboard players set #gen_failed dr_var 0
scoreboard players set #gen_fail_path dr_var 0
scoreboard players set #gen_cuts dr_var 0
scoreboard players set #gen_relieved dr_var 0
scoreboard players set #gen_wall_gaps dr_var 0
scoreboard players set #gen_wall_big dr_var 0
scoreboard players set #gen_wall_relaid dr_var 0
scoreboard players set #gen_tail_gaps dr_var 0
scoreboard players set #gen_strays dr_var 0
scoreboard players set #gen_cuts2 dr_var 0
scoreboard players set #gen_relieved2 dr_var 0
scoreboard players set #gen_no_second dr_var 0
scoreboard players set #gen_ends_opened dr_var 0
scoreboard players set #gen_supply_short dr_var 0
scoreboard players set #gen_repaints dr_var 0
scoreboard players set #gen_repair_swaps_total dr_var 0
scoreboard players set #gen_repair_paints_total dr_var 0
scoreboard players set #gen_spread_total dr_var 0
scoreboard players set #gen_fail_flat dr_var 0
scoreboard players set #gen_fail_second dr_var 0
scoreboard players set #gen_fresh_total dr_var 0
scoreboard players set #gen_fail_windows dr_var 0
scoreboard players set #gen_fail_shortcut dr_var 0
scoreboard players set #gen_fail_water dr_var 0
scoreboard players set #gen_fail_order dr_var 0
scoreboard players set #gen_searches dr_var 0
scoreboard players set #gen_order_fixed dr_var 0
scoreboard players set #gen_pieces_placed dr_var 0
scoreboard players set #gen_pieces_dropped dr_var 0
scoreboard players set #gen_fail_cheap dr_var 0
scoreboard players set #gen_fail_costly dr_var 0
scoreboard players set #gen_rate_n dr_var 0
scoreboard players set #gen_rate_sum dr_var 0
scoreboard players set #gen_rate_lo dr_var 2147483647
scoreboard players set #gen_rate_hi dr_var 0
scoreboard players set #gen_no_river dr_var 0
scoreboard players set #riv_fell dr_var 0
scoreboard players set #riv_joins dr_var 0
scoreboard players set #riv_lakes dr_var 0
scoreboard players set #riv_cuts dr_var 0
scoreboard players set #riv_dry dr_var 0
scoreboard players set #riv_refused dr_var 0

# A section queue left going stops, since this run starts the stack over
scoreboard players set #q_on dr_var 0
scoreboard players set #q_step dr_var 0
scoreboard players set #q_relay dr_var 0
scoreboard players set #gen_lenient dr_var 0
scoreboard players set #gen_lenient_sections dr_var 0
scoreboard players set #gen_leaks dr_var 0

# Marks the run as set up, last of all
scoreboard players set #gen_init_ok dr_var 1
