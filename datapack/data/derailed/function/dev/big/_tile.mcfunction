
# Lays this tile's marker where it takes a structure, which is everywhere but
#  iron and rock, since the mounds build those; the station's building is drawn
#  as rock but is ground under the station, on the mounds' map too
# Positioned on the tile

execute if block ~ ~-15 ~ obsidian run setblock ~ ~-14 ~ lime_concrete strict
execute unless block ~ ~-15 ~ obsidian if block ~ ~ ~ light_gray_concrete run return 0
execute unless block ~ ~-15 ~ obsidian if block ~ ~ ~ gray_concrete run return 0
execute summon marker run function derailed:dev/big/_new
