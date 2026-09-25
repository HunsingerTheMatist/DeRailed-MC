
# Draws the zone round this pinched cell of the first route: black out to four
#  steps along the grid, a diamond, where rock is never cut for the second
#  route, and light gray where that falls on the band, which is then both
# Positioned on the tile, with the first route three above and its pinched
#  cells gray there

execute unless block ~ ~3 ~ gray_stained_glass run return 0
fill ~-4 ~3 ~ ~4 ~3 ~ black_stained_glass replace air strict
fill ~-4 ~3 ~ ~4 ~3 ~ light_gray_stained_glass replace white_stained_glass strict
fill ~-3 ~3 ~-1 ~3 ~3 ~1 black_stained_glass replace air strict
fill ~-3 ~3 ~-1 ~3 ~3 ~1 light_gray_stained_glass replace white_stained_glass strict
fill ~-2 ~3 ~-2 ~2 ~3 ~2 black_stained_glass replace air strict
fill ~-2 ~3 ~-2 ~2 ~3 ~2 light_gray_stained_glass replace white_stained_glass strict
fill ~-1 ~3 ~-3 ~1 ~3 ~3 black_stained_glass replace air strict
fill ~-1 ~3 ~-3 ~1 ~3 ~3 light_gray_stained_glass replace white_stained_glass strict
fill ~ ~3 ~-4 ~ ~3 ~4 black_stained_glass replace air strict
fill ~ ~3 ~-4 ~ ~3 ~4 light_gray_stained_glass replace white_stained_glass strict
