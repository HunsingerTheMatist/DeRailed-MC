# Give items to the player. Run as the player
#
# Args: #curr_item, #give_count (both required)
#  #give_count is the amount to ADD, not the size of the resulting stack
#
# Updates the carried record, then redraws the hand from it

scoreboard players operation @s dr_item = #curr_item dr_arg
scoreboard players operation @s dr_count += #give_count dr_arg
function derailed:player/fix_items
