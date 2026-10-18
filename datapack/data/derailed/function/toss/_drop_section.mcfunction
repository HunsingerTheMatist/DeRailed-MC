# Starts a thrown pile here of as many of the #curr_item_count left to drop as
#  a section of a pile holds, '$BatchHeight', waiting '#drop_wait' ticks before
#  it falls, then goes on up a section with the rest, each waiting 3 ticks more
# Run at the bottom middle of the section
#
# Args: #curr_item, #curr_item_count, #curr_player_id, #curr_rotation

scoreboard players operation #drop_left dr_temp = #curr_item_count dr_arg
scoreboard players operation #curr_item_count dr_arg < $BatchHeight dr_const
summon item_display ~ ~ ~ {Tags:["dr_toss","dr_toss_new"],teleport_duration:1,Passengers:[{id:"minecraft:interaction",Tags:["dr_toss_box"],width:0.885f,height:0f}]}
execute as @n[type=item_display,tag=dr_toss_new,distance=..0.1] run function derailed:toss/_drop_ready

scoreboard players operation #curr_item_count dr_arg = #drop_left dr_temp
scoreboard players operation #curr_item_count dr_arg -= $BatchHeight dr_const
execute if score #curr_item_count dr_arg matches ..0 run return 0
scoreboard players add #drop_wait dr_temp 3

# Each section of a pile is three layers up from the last: 27 pixels of wood,
#  and 36 of iron or rails
execute if score #curr_item dr_arg = $Wood dr_const positioned ~ ~1.6875 ~ run return run function derailed:toss/_drop_section
execute positioned ~ ~2.25 ~ run function derailed:toss/_drop_section
