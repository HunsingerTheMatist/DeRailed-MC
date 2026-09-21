
# Moves to the rolled spot inside the section
# Takes $(x) and $(z), tile offsets from the section's corner

$execute positioned ~$(x) ~ ~$(z) run function derailed:dev/gen/_place
