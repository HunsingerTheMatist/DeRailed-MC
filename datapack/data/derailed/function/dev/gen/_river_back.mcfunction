
# Gives up on the branch the head is on and picks the river up from the last
#  choice it passed
# Run as the head

# The longest line so far is worth holding on to before it is thrown away, since
#  it is what gets laid if no start reaches an exit; a line given up because it
#  could not be laid is not, since it could not be laid then either
execute if score #riv_refusing dr_var matches 0 if score #riv_len dr_var > #riv_best dr_var run function derailed:dev/gen/_river_remember
scoreboard players set #riv_refusing dr_var 0

# Everything laid since that choice is written off in one sweep, which is what
#  the depth on a tile is for
execute as @e[type=marker,tag=dr_riv_path,distance=0..] if score @s dr_depth = #riv_depth dr_var unless entity @s[tag=dr_riv_dead] run function derailed:dev/gen/_river_write_off

# No choice left to come back to means there is no river to be had from this
#  start, so what it laid is cleared for the next
execute if score #riv_depth dr_var matches ..0 run return run function derailed:dev/gen/_river_wipe

function derailed:dev/gen/_river_resume
