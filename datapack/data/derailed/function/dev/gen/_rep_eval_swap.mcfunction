
# Scores the region tagged 'rep_cur' turned into '#rep_w' and this one turned
#  into the kind that one had, and keeps the pair as the best change so far if
#  it scores lowest yet
# Run as the region of '#rep_w' being swapped with

function derailed:dev/gen/_rep_vload
execute if score #rep_w dr_var matches 1 as @n[type=marker,tag=rep_cur,distance=0..] run function derailed:dev/gen/_rep_vw_add
execute if score #rep_w dr_var matches 1 run function derailed:dev/gen/_rep_vw_sub
execute if score #rep_w dr_var matches 2 as @n[type=marker,tag=rep_cur,distance=0..] run function derailed:dev/gen/_rep_vi_add
execute if score #rep_w dr_var matches 2 run function derailed:dev/gen/_rep_vi_sub

# Where the kind handed back is the other resource, the one region's tiles
#  leave it and this one's join it
execute if score #rep_k dr_var matches 1 as @n[type=marker,tag=rep_cur,distance=0..] run function derailed:dev/gen/_rep_vw_sub
execute if score #rep_k dr_var matches 1 run function derailed:dev/gen/_rep_vw_add
execute if score #rep_k dr_var matches 2 as @n[type=marker,tag=rep_cur,distance=0..] run function derailed:dev/gen/_rep_vi_sub
execute if score #rep_k dr_var matches 2 run function derailed:dev/gen/_rep_vi_add
function derailed:dev/gen/_rep_score_move

execute unless score #rep_score dr_var < #rep_best dr_var run return 0
scoreboard players operation #rep_best dr_var = #rep_score dr_var
tag @e[type=marker,tag=rep_ba,distance=0..] remove rep_ba
tag @e[type=marker,tag=rep_bb,distance=0..] remove rep_bb
tag @n[type=marker,tag=rep_cur,distance=0..] add rep_ba
tag @s add rep_bb
scoreboard players operation #rep_best_w dr_var = #rep_w dr_var
scoreboard players set #rep_best_swap dr_var 1
scoreboard players set #rep_found dr_var 1
