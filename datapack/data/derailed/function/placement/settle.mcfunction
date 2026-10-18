# Settles this placement after the blocks round it changed: where it still
#  stands, redraws what players bump into, since the change may have cleared
#  some of it, and where it no longer stands, drops it
# Run as the placement's interaction entity, at it

execute unless function derailed:placement/_supported run return run function derailed:placement/drop
function derailed:placement/_set_collision
