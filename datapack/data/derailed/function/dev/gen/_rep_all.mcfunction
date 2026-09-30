
# Takes the repair's search steps one after another until it is done
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

execute if function derailed:dev/gen/_rep_step run function derailed:dev/gen/_rep_all
