
# Draws the band beside this cell of the first route: white on the eight tiles
#  round it, where the second route walks for nothing
# Positioned on the tile, with the first route three above

execute unless block ~ ~3 ~ #derailed:second_route run return 0
fill ~-1 ~3 ~-1 ~1 ~3 ~1 white_stained_glass replace air strict
