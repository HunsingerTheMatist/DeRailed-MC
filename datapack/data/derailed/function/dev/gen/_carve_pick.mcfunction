
# Copies the nearest tile that is terrain other than rock onto this one, looking
#  next door first, then at the corners, then two away
# River is never copied here: it runs through a cut only when it stands at the
#  cut's end, which the run's own filling sees to
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
