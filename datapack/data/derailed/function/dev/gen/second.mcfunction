
# Finds the second way across: a route between the same two tiles as the first
#  that keeps off every cell of the first route where the train is pinched, so
#  that the players can always get round the train, walking the first route
#  everywhere else and leaving it only by detours of no more than
#  '#gen_detour_max' tiles, which cut rock only where no detour that short
#  can do without, and as little of it as will do
# It is judged for pinching like the first route and opened up the same way,
#  never for cost, and it is drawn on the route layer in magenta, pink where it
#  shares a tile with the first route
# Positioned at the section's corner, once the section has settled on its
#  first route

execute unless function derailed:dev/gen/_second_a run return 0
execute if score #sec_pinched dr_var matches 1 run function derailed:dev/gen/_second_search_a
execute if score #sec_pinched dr_var matches 1 run function derailed:dev/gen/_second_refind
execute if score #sec_pinched dr_var matches 1 if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_pinch_relieve
execute if score #sec_pinched dr_var matches 1 run function derailed:dev/gen/_second_search_b
function derailed:dev/gen/_second_b
