# An empty hand takes the resource of the half of the supply wagon clicked,
#  wood at the front and iron at the back, as many as the hand holds; wood or
#  iron in hand goes into the wagon, as many as there is room for; sneaking
#  narrows either to one, and anything else is refused
# Run as the player

execute if score @s dr_count matches ..0 run return run function derailed:train/supply_take
execute if score @s dr_item = $Wood dr_const run return run function derailed:train/supply_give
execute if score @s dr_item = $Iron dr_const run return run function derailed:train/supply_give
function derailed:item/reject
