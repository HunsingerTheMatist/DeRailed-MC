
# Opens one side of the longest pinched run, from its exit end, only as far as
#  brings what is left of it under the ceiling
# Positioned at the section's corner

# The longest run that would pass, counted down from the run as it is
scoreboard players operation #pinch_keep dr_var = #pinch_top dr_var
function derailed:dev/gen/_pinch_fit

# A window is three cells, so taking k windows off the run means opening the
#  first k plus two of its cells from the exit end, where its numbering starts
scoreboard players set #pinch_first dr_var 2147483647
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var run scoreboard players operation #pinch_first dr_var < @s dr_wave
scoreboard players operation #pinch_last dr_var = #pinch_first dr_var
scoreboard players operation #pinch_last dr_var += #pinch_top dr_var
scoreboard players operation #pinch_last dr_var -= #pinch_keep dr_var
scoreboard players add #pinch_last dr_var 1

execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var if score @s dr_wave <= #pinch_last dr_var at @s run function derailed:dev/gen/_pinch_open_at
