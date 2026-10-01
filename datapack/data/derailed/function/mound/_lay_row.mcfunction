
# Lays this row's markers and moves south, as far as the ring one row past the
#  map
# Positioned at the row's western end, in the ring west of the map

scoreboard players set #mi dr_temp -1
function derailed:mound/_lay_col
scoreboard players add #mj dr_temp 1
execute if score #mj dr_temp <= #mound_h dr_arg positioned ~ ~ ~1 run function derailed:mound/_lay_row
