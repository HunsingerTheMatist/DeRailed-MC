# Puts a pile down on the top of this floor block as it is drawn, whatever
#  stands there
# Run as the thrown display, at the bottom middle of the floor block

function derailed:item/_floor_top
execute if score #floor_top dr_temp matches 8 positioned ~ ~0.5 ~ run return run function derailed:item/place_new
execute if score #floor_top dr_temp matches 12 positioned ~ ~0.75 ~ run return run function derailed:item/place_new
execute if score #floor_top dr_temp matches 16 positioned ~ ~1 ~ run return run function derailed:item/place_new
execute if score #floor_top dr_temp matches 20 positioned ~ ~1.25 ~ run return run function derailed:item/place_new
