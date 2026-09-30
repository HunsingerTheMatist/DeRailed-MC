
# Starts a step of the search: scores the section and tries every change it may
#  make toward wood, returning 0 where the search is done instead
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

function derailed:dev/gen/_rep_measure
scoreboard players operation #rep_now dr_var = #rep_score dr_var
execute if score #rep_now dr_var matches ..0 run return 0
execute if score #rep_steps dr_var matches ..0 run return 0
scoreboard players remove #rep_steps dr_var 1

scoreboard players operation #rep_best dr_var = #rep_now dr_var
scoreboard players set #rep_found dr_var 0
tag @e[type=marker,tag=rep_ba,distance=0..] remove rep_ba
tag @e[type=marker,tag=rep_bb,distance=0..] remove rep_bb

# Only a kind that falls short somewhere is worth turning regions into: a
#  trade of wood for iron that helps iron is tried from iron's side as well
scoreboard players operation #rep_now_w dr_var = #rep_sw dr_var
scoreboard players operation #rep_now_i dr_var = #rep_si dr_var
scoreboard players set #rep_w dr_var 1
execute if score #rep_now_w dr_var matches 1.. run function derailed:dev/gen/_rep_try_kind
return 1
