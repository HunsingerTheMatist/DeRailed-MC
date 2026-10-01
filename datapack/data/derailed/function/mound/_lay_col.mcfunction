
# Lays a tile's marker here, and a corner's a layer above where this is a corner
#  of the map's tiles, then moves east, as far as the ring one column past the
#  map
# Positioned on the tile

execute summon marker run function derailed:mound/_tile_new
execute if score #mi dr_temp matches 0.. if score #mj dr_temp matches 0.. positioned ~ ~1 ~ summon marker run function derailed:mound/_corner_new
scoreboard players add #mi dr_temp 1
execute if score #mi dr_temp <= #mound_w dr_arg positioned ~1 ~ ~ run function derailed:mound/_lay_col
