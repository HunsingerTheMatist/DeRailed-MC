# Empties this placement, moved aside
# Run as the placement's interaction entity, at it

scoreboard players operation #curr_item dr_arg = @s dr_item
scoreboard players set @s dr_count 0
function derailed:placement/update_placement
