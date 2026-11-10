
# Covers this column's tiles but its preview, then the next column east, as
#  far as the last
# Positioned at the column's northern tile

scoreboard players set #pv_r dr_var 0
function derailed:dev/gen/_preview_tile
scoreboard players add #pv_c dr_var 1
execute if score #pv_c dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_preview_col
