# Find somewhere near here to put #curr_item_count of #curr_item, as
#  'item/place_near' does, spot by spot, the start first
# Run as the player, at the bottom middle of the block the search starts from
#
# Args: #curr_item, #curr_player_id, #curr_item_count
#  The caller has already taken the items off the player, so whatever finds
#  nowhere ends in 'place_fail' handing it back

execute if function derailed:item/place_near run return 1
function derailed:item/place_fail
return fail
