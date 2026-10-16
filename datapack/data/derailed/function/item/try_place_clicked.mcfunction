# Try to put #curr_item_count of #curr_item where the player clicked and
#  nowhere else: onto the placement reaching into this block or the one under
#  it, if it is of the same item, or else onto the floor here
# Run as the player, at the bottom middle of the clicked block
#
# Args: #curr_item, #curr_player_id, #curr_item_count
#  The caller has already taken the items off the player, so a refusal ends
#  in 'place_fail' handing them back

execute if function derailed:item/_place_clicked run return 1
function derailed:item/place_fail
return fail
