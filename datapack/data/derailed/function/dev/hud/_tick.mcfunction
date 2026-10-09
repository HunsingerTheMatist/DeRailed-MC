
# Redraws the HUD test: the picture, then an arrow for every player in the
#  game's dimension, sent to every player in their own frame; then runs again
#  in two ticks

data modify storage derailed:hud content set value {text:"",extra:[]}
data modify storage derailed:hud content.extra append from storage derailed:hud board
execute in derailed:game as @a[distance=0..] run function derailed:dev/hud/_marker
execute as @a run function derailed:dev/hud/_send
schedule function derailed:dev/hud/_tick 2t replace
