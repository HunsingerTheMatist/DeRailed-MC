# Tries the blocks within 20 steps of here, cheapest first, from the list
#  for how far the start stands above the map's lowest, which '#sy0' holds as a
#  negative: a start below the map's heights takes the lowest's list and one
#  above them the highest's, the map taken to be 15 blocks high
# Written by 'utils/generate_search.py'; edit that and run it again rather than
#  this
# Run at the bottom middle of the block the search starts from
#
# Returns 1 once all the items are down, fail otherwise

execute if score #sy0 dr_temp matches 0.. run return run function derailed:item/_spots/h0
execute if score #sy0 dr_temp matches -1 run return run function derailed:item/_spots/h1
execute if score #sy0 dr_temp matches -2 run return run function derailed:item/_spots/h2
execute if score #sy0 dr_temp matches -3 run return run function derailed:item/_spots/h3
execute if score #sy0 dr_temp matches -4 run return run function derailed:item/_spots/h4
execute if score #sy0 dr_temp matches -5 run return run function derailed:item/_spots/h5
execute if score #sy0 dr_temp matches -6 run return run function derailed:item/_spots/h6
execute if score #sy0 dr_temp matches -7 run return run function derailed:item/_spots/h7
execute if score #sy0 dr_temp matches -8 run return run function derailed:item/_spots/h8
execute if score #sy0 dr_temp matches -9 run return run function derailed:item/_spots/h9
execute if score #sy0 dr_temp matches -10 run return run function derailed:item/_spots/h10
execute if score #sy0 dr_temp matches -11 run return run function derailed:item/_spots/h11
execute if score #sy0 dr_temp matches -12 run return run function derailed:item/_spots/h12
execute if score #sy0 dr_temp matches -13 run return run function derailed:item/_spots/h13
execute if score #sy0 dr_temp matches -14 run return run function derailed:item/_spots/h14
return run function derailed:item/_spots/h15
