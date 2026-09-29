
# Adds what this tile costs to step onto to each route that runs over it,
#  '#price_first' for the first route and '#price_second' for the second
# Positioned on the tile, with the routes drawn two above: red for the first
#  alone, magenta for the second alone and pink for both

execute unless block ~ ~2 ~ #derailed:routes run return 0
function derailed:dev/gen/_price_tile
execute if block ~ ~2 ~ #derailed:first_route run scoreboard players operation #price_first dr_var += #price_c dr_var
execute unless block ~ ~2 ~ red_stained_glass run scoreboard players operation #price_second dr_var += #price_c dr_var
