
# Copies the nearest tile that is terrain other than rock onto this one, looking
#  next door first, then at the corners, then two away, and makes this tile part
#  of the region the copy came from
# River is never copied here: it runs through a cut only when it stands at the
#  cut's end, which the run's own filling sees to
# Positioned on the tile

execute if block ~1 ~ ~ #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:1,z:0}
execute if block ~-1 ~ ~ #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:-1,z:0}
execute if block ~ ~ ~1 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:0,z:1}
execute if block ~ ~ ~-1 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:0,z:-1}

execute if block ~1 ~ ~1 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:1,z:1}
execute if block ~1 ~ ~-1 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:1,z:-1}
execute if block ~-1 ~ ~1 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:-1,z:1}
execute if block ~-1 ~ ~-1 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:-1,z:-1}

execute if block ~2 ~ ~ #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:2,z:0}
execute if block ~-2 ~ ~ #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:-2,z:0}
execute if block ~ ~ ~2 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:0,z:2}
execute if block ~ ~ ~-2 #derailed:carve_from run return run function derailed:dev/gen/_carve_from {x:0,z:-2}

# Nothing but rock and river all round: ground, of no region
setblock ~ ~ ~ lime_concrete strict
