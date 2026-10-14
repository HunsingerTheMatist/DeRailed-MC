# Lowers '#want_count' until nothing stands where that many of #curr_item would
#  collide, as 'item/_entity_in_way' tests, as far as '#want_min'
# Run at the bottom middle of a block in the placement's column
#
# Returns 1 when some count fits, fail when even '#want_min' would collide

execute unless function derailed:item/_entity_in_way run return 1
execute if score #want_count dr_temp <= #want_min dr_temp run return fail
scoreboard players remove #want_count dr_temp 1
return run function derailed:item/_fit_entities
