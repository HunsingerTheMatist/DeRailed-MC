
# Marks this tile 'dr_cp' where the first route runs over it
# Positioned on the tile, with the routes drawn two above

execute if block ~ ~2 ~ #derailed:first_route run summon marker ~ ~ ~ {Tags:["dr_cp"]}
