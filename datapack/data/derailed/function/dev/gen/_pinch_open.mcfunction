
# Opens one side of the pinched run '#pinch_top_id', '#pinch_top' cells long,
#  from one end: its exit end, or its entry end with '#pinch_from' at 1; only
#  as far as brings what is left of it under the ceiling, or '#pinch_take'
#  cells where that is not -1
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

execute if score #pinch_take dr_var matches 0.. run scoreboard players operation #pinch_keep dr_var = #pinch_top dr_var
execute if score #pinch_take dr_var matches 0.. run scoreboard players operation #pinch_keep dr_var -= #pinch_take dr_var

# Taking k boxes off the run means opening the k of its cells at the end it is
#  opened from, each along with the cell ahead of it; its numbering starts at
#  its exit end
scoreboard players set #pinch_lo dr_var 2147483647
scoreboard players set #pinch_hi dr_var -2147483648
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var run scoreboard players operation #pinch_lo dr_var < @s dr_wave
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var run scoreboard players operation #pinch_hi dr_var > @s dr_wave
scoreboard players operation #pinch_n dr_var = #pinch_top dr_var
scoreboard players operation #pinch_n dr_var -= #pinch_keep dr_var
execute if score #pinch_from dr_var matches 0 run scoreboard players operation #pinch_hi dr_var = #pinch_lo dr_var
execute if score #pinch_from dr_var matches 0 run scoreboard players operation #pinch_hi dr_var += #pinch_n dr_var
execute if score #pinch_from dr_var matches 0 run scoreboard players remove #pinch_hi dr_var 1
execute if score #pinch_from dr_var matches 1 run scoreboard players operation #pinch_lo dr_var = #pinch_hi dr_var
execute if score #pinch_from dr_var matches 1 run scoreboard players operation #pinch_lo dr_var -= #pinch_n dr_var
execute if score #pinch_from dr_var matches 1 run scoreboard players add #pinch_lo dr_var 1

# The side opened is whichever has less rock along those cells, so that the
#  opening cuts as little as it can, never one with no rock to cut, and never
#  one that faces out of the section, since the edge closes a side but is not
#  rock to cut
scoreboard players set #pinch_lrock dr_var 0
scoreboard players set #pinch_rrock dr_var 0
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var if score @s dr_wave >= #pinch_lo dr_var if score @s dr_wave <= #pinch_hi dr_var at @s run function derailed:dev/gen/_pinch_side_at
scoreboard players set #pinch_side dr_var 1
execute if score #pinch_lrock dr_var matches 0 run scoreboard players set #pinch_side dr_var 2
execute if score #pinch_rrock dr_var matches 1.. if score #pinch_rrock dr_var < #pinch_lrock dr_var run scoreboard players set #pinch_side dr_var 2

execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pinch_top_id dr_var if score @s dr_wave >= #pinch_lo dr_var if score @s dr_wave <= #pinch_hi dr_var at @s run function derailed:dev/gen/_pinch_open_at
