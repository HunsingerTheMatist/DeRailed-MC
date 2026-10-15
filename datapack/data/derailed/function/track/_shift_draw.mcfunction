# Draws this placement as a planned move aside left it, no longer reserved
# Run as the placement's interaction entity, at it

tag @s remove dr_reserved
scoreboard players operation #curr_item dr_arg = @s dr_item
function derailed:placement/update_placement
