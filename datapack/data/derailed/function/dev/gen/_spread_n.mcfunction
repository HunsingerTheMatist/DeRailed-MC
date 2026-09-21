
# Carries the flood on, trying north before south

execute positioned ~1 ~ ~ run function derailed:dev/gen/_flood_e
execute positioned ~ ~ ~-1 run function derailed:dev/gen/_flood_n
execute positioned ~ ~ ~1 run function derailed:dev/gen/_flood_s
execute positioned ~-1 ~ ~ run function derailed:dev/gen/_flood_w
