
# Opens one side of the longest pinched run, from its exit end, only as far as
#  brings what is left of it under the ceiling
# Positioned at the section's corner

execute summon marker run function derailed:dev/gen/_read_corner

# The longest run that would pass, counted down from the run as it is against
#  the room the ceiling leaves once the other runs are counted, and no further
#  than the floor can spare where the other runs fall short of it
scoreboard players operation #pinch_cube dr_var = #pinch_top dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_top dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_top dr_var
scoreboard players operation #pinch_rest dr_var = #gen_pinch dr_var
scoreboard players operation #pinch_rest dr_var -= #pinch_cube dr_var
scoreboard players operation #pinch_room dr_var = #gen_pinch_max dr_var
scoreboard players operation #pinch_room dr_var -= #pinch_rest dr_var
scoreboard players set #pinch_keep_min dr_var 0
execute if score #cost_mode dr_var matches 0 if score #pinch_rest dr_var < #gen_pinch_min dr_var run scoreboard players set #pinch_keep_min dr_var 2
scoreboard players operation #pinch_keep dr_var = #pinch_top dr_var
function derailed:dev/gen/_pinch_fit

# Taking k boxes off the run means opening the first k of its cells from the
#  exit end, where its numbering starts, each along with the cell ahead of it
scoreboard players set #pinch_first dr_var 2147483647
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var run scoreboard players operation #pinch_first dr_var < @s dr_wave
scoreboard players operation #pinch_last dr_var = #pinch_first dr_var
scoreboard players operation #pinch_last dr_var += #pinch_top dr_var
scoreboard players operation #pinch_last dr_var -= #pinch_keep dr_var
scoreboard players remove #pinch_last dr_var 1

# The side opened is whichever has less rock along those cells, so that the
#  opening cuts as little as it can, never one with no rock to cut, and never
#  one that faces out of the section, since the edge closes a side but is not
#  rock to cut
scoreboard players set #pinch_lrock dr_var 0
scoreboard players set #pinch_rrock dr_var 0
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var if score @s dr_wave <= #pinch_last dr_var at @s run function derailed:dev/gen/_pinch_side_at
scoreboard players set #pinch_side dr_var 1
execute if score #pinch_lrock dr_var matches 0 run scoreboard players set #pinch_side dr_var 2
execute if score #pinch_rrock dr_var matches 1.. if score #pinch_rrock dr_var < #pinch_lrock dr_var run scoreboard players set #pinch_side dr_var 2

execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var if score @s dr_wave <= #pinch_last dr_var at @s run function derailed:dev/gen/_pinch_open_at
