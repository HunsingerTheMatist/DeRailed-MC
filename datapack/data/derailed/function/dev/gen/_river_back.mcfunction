
# Gives up on the branch the head is on and picks the river up from the last
#  choice it passed
# Run as the head

# A section picking up from the one before cannot start anywhere else, so the
#  longest it manages is worth holding on to before it is thrown away
execute if score #riv_forced dr_var matches 1 if score #riv_len dr_var > #riv_best dr_var run function derailed:dev/gen/_river_remember

# Everything laid since that choice is written off in one sweep, which is what
#  the depth on a tile is for
execute as @e[type=marker,tag=dr_riv_path,distance=0..] if score @s dr_depth = #riv_depth dr_var unless entity @s[tag=dr_riv_dead] run function derailed:dev/gen/_river_write_off

# No choice left to come back to means there is no river to be had from this seed
execute if score #riv_depth dr_var matches ..0 run return run function derailed:dev/gen/_river_exhausted

function derailed:dev/gen/_river_resume
