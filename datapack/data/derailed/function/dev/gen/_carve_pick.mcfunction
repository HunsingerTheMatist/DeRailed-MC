
# Copies the nearest tile that is terrain other than rock onto this one, looking
#  next door first, then at the corners, then two away
# River is never copied: a passage is cut through rock, not opened into water
# Positioned on the tile

execute if block ~1 ~ ~ #derailed:carve_from run return run clone ~1 ~ ~ ~1 ~ ~ ~ ~ ~ strict
execute if block ~-1 ~ ~ #derailed:carve_from run return run clone ~-1 ~ ~ ~-1 ~ ~ ~ ~ ~ strict
execute if block ~ ~ ~1 #derailed:carve_from run return run clone ~ ~ ~1 ~ ~ ~1 ~ ~ ~ strict
execute if block ~ ~ ~-1 #derailed:carve_from run return run clone ~ ~ ~-1 ~ ~ ~-1 ~ ~ ~ strict

execute if block ~1 ~ ~1 #derailed:carve_from run return run clone ~1 ~ ~1 ~1 ~ ~1 ~ ~ ~ strict
execute if block ~1 ~ ~-1 #derailed:carve_from run return run clone ~1 ~ ~-1 ~1 ~ ~-1 ~ ~ ~ strict
execute if block ~-1 ~ ~1 #derailed:carve_from run return run clone ~-1 ~ ~1 ~-1 ~ ~1 ~ ~ ~ strict
execute if block ~-1 ~ ~-1 #derailed:carve_from run return run clone ~-1 ~ ~-1 ~-1 ~ ~-1 ~ ~ ~ strict

execute if block ~2 ~ ~ #derailed:carve_from run return run clone ~2 ~ ~ ~2 ~ ~ ~ ~ ~ strict
execute if block ~-2 ~ ~ #derailed:carve_from run return run clone ~-2 ~ ~ ~-2 ~ ~ ~ ~ ~ strict
execute if block ~ ~ ~2 #derailed:carve_from run return run clone ~ ~ ~2 ~ ~ ~2 ~ ~ ~ strict
execute if block ~ ~ ~-2 #derailed:carve_from run return run clone ~ ~ ~-2 ~ ~ ~-2 ~ ~ ~ strict

# Nothing but rock and river all round: ground
setblock ~ ~ ~ lime_concrete strict
