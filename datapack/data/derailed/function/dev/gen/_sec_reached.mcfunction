
# Leaves '#gen_reached' at 1 where the walk back reached the tile the track
#  comes in on, $(entry) rows down column $(start), and 0 where it stopped
#  short
# Takes $(entry), the row the track enters on, and $(start), the column of its
#  first tile
# Positioned at the section's corner

$execute store success score #gen_reached dr_var if block ~$(start) ~2 ~$(entry) red_stained_glass
