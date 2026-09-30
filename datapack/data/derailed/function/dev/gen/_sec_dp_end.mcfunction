
# Ends the stretch-by-stretch search once every stretch is settled: whether the
#  entry's stretch was reached, and the whole worked out again joining every
#  stretch as near its start as it was reached where not
# Positioned at the section's corner

scoreboard players set #sec_found dr_var 0
execute as @e[type=marker,tag=dr_rej,distance=0..] if score @s dr_str = #sec_last dr_var run scoreboard players set #sec_found dr_var 1

# Joining each stretch at its cheapest tile can leave the next detour nowhere to
#  leave from, so where that finds no way, every stretch is joined as near its
#  start as it was reached and the whole is worked out again
execute if score #sec_found dr_var matches 0 if score #sec_fb dr_var matches 0 run function derailed:dev/gen/_sec_dp_fallback
