
# Draws the HUD test's picture into storage: the strip above the board, each
#  row of the northwestern 25.6 by 16 tiles of section '#big_section' as one
#  run of tile glyphs, then the strip below; each tile is a variant of its kind
#  taken from 'derailed:hud_tiles' started over, so it always comes out the same

data modify storage derailed:hud board set value {text:"",extra:[{text:""}]}
data modify storage derailed:hud board.extra[-1].text set from storage derailed:hud strips.top
random reset derailed:hud_tiles 0 false false

scoreboard players operation #hud_x dr_temp = #big_section dr_var
scoreboard players operation #hud_x dr_temp *= $SectionWidth dr_const
execute store result storage derailed:hud s.x int 1 run scoreboard players add #hud_x dr_temp 1000
scoreboard players set #hud_r dr_temp 0
function derailed:dev/hud/_board_at with storage derailed:hud s

data modify storage derailed:hud board.extra append value {text:""}
data modify storage derailed:hud board.extra[-1].text set from storage derailed:hud strips.bottom
