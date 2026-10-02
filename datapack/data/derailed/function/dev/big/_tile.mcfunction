
# Lays this tile's marker; the station's building is drawn as rock but is
#  ground under the station, on the mounds' map too
# Positioned on the tile

execute if block ~ ~-15 ~ obsidian run setblock ~ ~-14 ~ lime_concrete strict
execute summon marker run function derailed:dev/big/_new
