# Returns 1 when an entity a player could bump into overlaps the box $(box_y)
#  up from here, the whole block across and $(box_dy) more than a block tall,
#  fail otherwise
# Displays, interactions, markers, item entities and the piles' own shulkers
#  are passed over
# Run at the bottom middle of a block

$execute positioned ~-0.5 ~$(box_y) ~-0.5 if entity @e[type=!interaction,type=!item_display,type=!block_display,type=!text_display,type=!marker,type=!item,tag=!dr_pile_box,dx=0,dy=$(box_dy),dz=0] run return 1
return fail
