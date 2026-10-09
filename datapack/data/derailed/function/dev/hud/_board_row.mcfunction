
# Draws this row of the board as one run of glyphs, the board's width back at
#  its end, then the row below
# Positioned on the row's western tile

data modify storage derailed:hud a.row set value ""
scoreboard players set #hud_c dr_temp 0
function derailed:dev/hud/_board_col
data modify storage derailed:hud a.ch set from storage derailed:hud strips.row_end
function derailed:dev/hud/_board_join with storage derailed:hud a
data modify storage derailed:hud board.extra append value {text:""}
data modify storage derailed:hud board.extra[-1].text set from storage derailed:hud a.row

scoreboard players add #hud_r dr_temp 1
execute if score #hud_r dr_temp matches ..15 positioned ~ ~ ~1 run function derailed:dev/hud/_board_row
