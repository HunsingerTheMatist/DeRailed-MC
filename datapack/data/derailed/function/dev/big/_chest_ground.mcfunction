
# Succeeds where a player could stand on this tile once anything mined off it is
#  cleared: on ground, a tree or iron, and not on rock, water, the void or a
#  station's tile
# Positioned over the tile

execute if block ~ 14 ~ #derailed:ray_passable run return 0
execute if block ~ 14 ~ #derailed:water_like run return 0
execute if block ~ 15 ~ bedrock run return 0
execute if block ~ 1 ~ light run return 0
return 1
