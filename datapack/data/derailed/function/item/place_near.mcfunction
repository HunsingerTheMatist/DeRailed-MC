# Puts #curr_item_count of #curr_item down near here, as many as each spot takes,
#  nearest first, splitting them across spots where none takes them all
# Spots are tried in the order 'item/_try_spots' gives, within the map's limits
# Run at the bottom middle of the block the search starts from
#
# Returns 1 once all of them are down, fail otherwise, with '#search_left' how
#  many are not

function derailed:item/_search_window

# Whether any placement stands within reach, for blocks to look for one in; no
#  block it tries is more than 20 away
execute store success score #piles_near dr_temp if entity @e[type=interaction,tag=dr_placement,tag=!dr_shift,distance=..21]

scoreboard players operation #search_left dr_temp = #curr_item_count dr_arg
return run function derailed:item/_try_spots
