
# Lays this row's markers and moves south, as far as the ring one row past the
#  map
# Positioned at the row's western end, in the ring west of the map

scoreboard players set #mi dr_var -1
function derailed:dev/mound/_lay_col
scoreboard players add #mj dr_var 1
execute if score #mj dr_var <= #mhh dr_var positioned ~ ~ ~1 run function derailed:dev/mound/_lay_row
