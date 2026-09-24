
# Gives this region the kind wanting in the window, and a region of that kind
#  from outside the window, taken at random and never one the first route runs
#  through, the kind this one had
# With no such region to swap with, this one is repainted outright and the
#  section holds one more of the kind
# Run as the region inside the window, positioned at the section's corner

scoreboard players operation #sp_had dr_var = @s dr_kind
function derailed:dev/gen/_supply_repaint
scoreboard players set #sp_fixed dr_var 1
scoreboard players remove #sp_rounds dr_var 1

scoreboard players operation #sp_want_keep dr_var = #sup_want dr_var
scoreboard players operation #sup_want dr_var = #sp_had dr_var
execute if score #sp_want_keep dr_var matches 1 as @e[type=marker,tag=dr_seed,tag=dr_supply,tag=!dr_win,tag=!dr_on_first,scores={dr_kind=1},distance=0..,sort=random,limit=1] run function derailed:dev/gen/_supply_repaint
execute if score #sp_want_keep dr_var matches 2 as @e[type=marker,tag=dr_seed,tag=dr_supply,tag=!dr_win,tag=!dr_on_first,scores={dr_kind=2},distance=0..,sort=random,limit=1] run function derailed:dev/gen/_supply_repaint
scoreboard players operation #sup_want dr_var = #sp_want_keep dr_var
