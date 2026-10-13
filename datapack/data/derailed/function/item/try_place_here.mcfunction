# Try to put #curr_item_count of #curr_item in this column: on the placement
#  found going down it, or else on the floor under it, as many as there is room
#  for under the first block in the way above
# Run as the player, at the bottom middle of a block
#
# Returns 1 when any items were placed, fail otherwise

scoreboard players set #scan_cells dr_temp 0
scoreboard players set #scan_first dr_temp 1
return run function derailed:item/_scan_column
