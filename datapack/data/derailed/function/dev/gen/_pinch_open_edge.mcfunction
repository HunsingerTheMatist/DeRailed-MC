
# Opens one run tagged 'dr_pinch_edge' from the end of the route it lies
#  against, the exit end where it lies against both: as far as brings the
#  section under its ceiling, or with '#pinch_near' at 1 only its cells within
#  two tiles of that end
# Positioned at the section's corner

execute as @n[type=marker,tag=dr_pinch_edge,distance=0..] run scoreboard players operation #pinch_top_id dr_var = @s dr_step
scoreboard players set #pinch_top dr_var 0
scoreboard players set #pinch_near_in dr_var 0
scoreboard players set #pinch_near_out dr_var 0
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var run function derailed:dev/gen/_pinch_edge_count

scoreboard players set #pinch_from dr_var 0
scoreboard players operation #pinch_take dr_var = #pinch_near_out dr_var
execute if score #pinch_near_out dr_var matches 0 run scoreboard players set #pinch_from dr_var 1
execute if score #pinch_near_out dr_var matches 0 run scoreboard players operation #pinch_take dr_var = #pinch_near_in dr_var
execute if score #pinch_near dr_var matches 0 run scoreboard players set #pinch_take dr_var -1

function derailed:dev/gen/_pinch_open
scoreboard players set #pinch_take dr_var -1
scoreboard players set #pinch_from dr_var 0

execute as @e[type=marker,tag=dr_pinch_edge,distance=0..] if score @s dr_step = #pinch_top_id dr_var run tag @s remove dr_pinch_edge
