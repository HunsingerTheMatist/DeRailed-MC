
# Starts the font-based HUD test: map 7's picture in its paper border in the
#  screen's bottom-left corner, through the action bar, its board the
#  northwestern 25.6 by 16 tiles of section '#big_section', with an arrow for
#  every player where they stand on its large version, coloured for each and
#  turned the way they face, redrawn every other tick until 'dev/hud/stop'
# Each player gives their monitor's width in pixels, 'dr_hud_monitor', 1920
#  unless set, and their GUI scale, 'dr_hud_gui', 2 unless set, which places
#  it and picks its scale; 'dr_hud_scale' 1, 2 or 3 picks that many GUI
#  pixels to a map pixel instead
# Needs the resource pack loaded

function derailed:dev/hud/tables
function derailed:dev/hud/board
schedule function derailed:dev/hud/_tick 1t replace
