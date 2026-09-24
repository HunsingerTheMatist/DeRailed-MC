
# Stands the supply check's flood on this tile if the first route runs over it
# Positioned on the tile, with the routes kept three above

execute unless block ~ ~3 ~ #derailed:first_route run return 0
setblock ~ ~2 ~ white_stained_glass strict
summon marker ~ ~ ~ {Tags:["dr_flood","dr_f0"]}
