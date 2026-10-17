# Throws #curr_item_count of #curr_item out from this player's eyes along their
#  aim, slower the more there are: a display of them, carrying an interaction
#  the size of the pile they make, which is the box it collides with, centred
#  on the eyes; 'toss/tick' moves it from then on; takes the items off the
#  player
# Run as the player, at their eyes, facing where they aim
#
# Args: #curr_item, #curr_item_count, #curr_player_id, #curr_rotation

execute summon marker run function derailed:toss/_aim
summon item_display ~ ~ ~ {Tags:["dr_toss","dr_toss_new"],teleport_duration:1,Passengers:[{id:"minecraft:interaction",Tags:["dr_toss_box"],width:0.885f,height:0f}]}
execute as @n[type=item_display,tag=dr_toss_new,distance=..0.1] run function derailed:toss/_launch
function derailed:player/take_items
