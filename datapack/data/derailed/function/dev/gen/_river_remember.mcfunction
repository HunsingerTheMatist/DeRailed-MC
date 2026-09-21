
# Keeps hold of the longest path the search has managed so far

tag @e[type=marker,tag=dr_riv_best,distance=0..] remove dr_riv_best
execute as @e[type=marker,tag=dr_riv_path,distance=0..] unless entity @s[tag=dr_riv_dead] run tag @s add dr_riv_best
scoreboard players operation #riv_best dr_var = #riv_len dr_var
