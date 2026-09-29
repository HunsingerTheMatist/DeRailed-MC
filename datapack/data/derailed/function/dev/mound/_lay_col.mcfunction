
# Lays a tile's marker here, and a corner's a layer above where this is a corner
#  of the map's tiles, then moves east, as far as the ring one column past the
#  map
# Positioned on the tile

execute summon marker run function derailed:dev/mound/_tile_new with storage derailed:mound a
execute if score #mi dr_var matches 0.. if score #mj dr_var matches 0.. positioned ~ ~1 ~ summon marker run function derailed:dev/mound/_corner_new
scoreboard players add #mi dr_var 1
execute if score #mi dr_var <= #mw dr_var positioned ~1 ~ ~ run function derailed:dev/mound/_lay_col
