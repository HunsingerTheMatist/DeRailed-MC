# Nowhere would take the resources. Run as the player
#
# The record was never touched, so redrawing the hand from it puts back
#  anything vanilla removed on the way in

tellraw @a "FAIL"

function derailed:player/fix_resources
