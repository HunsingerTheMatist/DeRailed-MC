
# Takes every reached region of wood or iron not yet taken with '#sup_k' tiles
#  of water on the way to it, then moves on to the next count
# Positioned at the section's corner

execute as @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_used,distance=0..] if score @s dr_kind matches 1..2 if score @s dr_bridge = #sup_k dr_var at @s positioned ~ ~15 ~ run function derailed:dev/gen/_supply_take
scoreboard players add #sup_k dr_var 1
execute if score #sup_k dr_var matches ..8 run function derailed:dev/gen/_supply_round
