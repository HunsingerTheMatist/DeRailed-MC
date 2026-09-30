
# One step of the search: scores the section, tries every change it may make
#  toward wood and toward iron, and makes the best of them if it lowers the
#  score, returning 1 where it made one and a step is worth taking after it
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

execute unless function derailed:dev/gen/_rep_step_wood run return 0
return run function derailed:dev/gen/_rep_step_iron
