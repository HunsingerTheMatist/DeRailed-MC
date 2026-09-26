
# Makes the best change the step found: the region tagged 'rep_ba' becomes the
#  kind wanted, and in a swap the one tagged 'rep_bb' takes the kind it had
# Positioned at the section's corner

execute as @n[type=marker,tag=rep_ba,distance=0..] run scoreboard players operation #rep_had dr_var = @s dr_kind
scoreboard players operation #sup_want dr_var = #rep_best_w dr_var
execute as @n[type=marker,tag=rep_ba,distance=0..] run function derailed:dev/gen/_supply_repaint

scoreboard players operation #sup_want dr_var = #rep_had dr_var
execute if score #rep_best_swap dr_var matches 1 as @n[type=marker,tag=rep_bb,distance=0..] run function derailed:dev/gen/_supply_repaint
execute if score #rep_best_swap dr_var matches 1 run scoreboard players add #gen_repair_swaps dr_var 1
execute if score #rep_best_swap dr_var matches 0 run scoreboard players add #gen_repair_paints dr_var 1

tag @e[type=marker,tag=rep_ba,distance=0..] remove rep_ba
tag @e[type=marker,tag=rep_bb,distance=0..] remove rep_bb
