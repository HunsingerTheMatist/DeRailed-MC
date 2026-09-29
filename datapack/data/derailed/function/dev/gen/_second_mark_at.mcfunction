
# Colours this tile on the route layer: pink where both routes run, magenta
#  where the second alone does, and red where the first alone does
# Positioned on the tile, with the second route drawn in red two above and the
#  first three above

execute if block ~ ~2 ~ red_stained_glass if block ~ ~3 ~ #derailed:second_route run return run setblock ~ ~2 ~ pink_stained_glass strict
execute if block ~ ~2 ~ red_stained_glass run return run setblock ~ ~2 ~ magenta_stained_glass strict
execute if block ~ ~3 ~ #derailed:second_route run setblock ~ ~2 ~ red_stained_glass strict
