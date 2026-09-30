
# Checks that the section holds enough wood and iron within reach of the route
#  to lay it, and repaints a region as whichever is short until it does
# Each route needs a wood and an iron for every rail and a bridge for every tile
#  of water under it, and the section is held to the costlier of the two; what
#  is within reach is found by a flood from the first route, water costing one
#  for the bridge to it and rock never crossed, and regions are drawn on
#  cheapest first, each bridge on the way charged once
# Positioned at the section's corner, once both routes are found

execute unless function derailed:dev/gen/_supply_a run return 0
function derailed:dev/gen/_rep_all
function derailed:dev/gen/_supply_c
