
# Keeps hold of the longest line the search has managed so far, and of the
#  column it set out from

# A line held from an earlier start was let go of the lattice when that start
#  was cleared, so nothing else is going to kill it
kill @e[type=marker,tag=dr_riv_best,tag=!dr_riv_path,distance=0..]
tag @e[type=marker,tag=dr_riv_best,distance=0..] remove dr_riv_best
execute as @e[type=marker,tag=dr_riv_path,distance=0..] unless entity @s[tag=dr_riv_dead] run tag @s add dr_riv_best

scoreboard players operation #riv_best dr_var = #riv_len dr_var
scoreboard players operation #riv_best_col dr_var = #riv_col_try dr_var
