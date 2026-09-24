
# Draws the band round this cell of the first route: white on the eight tiles
#  beside it, where the second route walks for nothing, and black out to four
#  tiles, where rock is never cut for it
# Positioned on the tile, with the first route three above

execute unless block ~ ~3 ~ #derailed:second_route run return 0
fill ~-1 ~3 ~-1 ~1 ~3 ~1 white_stained_glass replace air strict
fill ~-4 ~3 ~-4 ~4 ~3 ~4 black_stained_glass replace air strict
