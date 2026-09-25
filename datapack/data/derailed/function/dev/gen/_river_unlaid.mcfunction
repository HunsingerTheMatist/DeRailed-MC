
# Gives up the longest line, which could be laid on no side without carving a
#  prefab, and the section goes without this river

scoreboard players set #riv_done dr_var 0
scoreboard players add #riv_refused dr_var 1
scoreboard players add #gen_no_river dr_var 1
tag @e[type=marker,tag=dr_riv_keep,distance=0..] remove dr_riv_keep
tag @e[type=marker,tag=dr_riv_line,distance=0..] remove dr_riv_line
tag @e[type=marker,tag=dr_riv_end,distance=0..] remove dr_riv_end
