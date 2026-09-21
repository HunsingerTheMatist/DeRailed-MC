
# Builds the section whose corner is at $(x)
# The section sits a block up so that the layer under it is free to hold a copy

$execute in derailed:game positioned $(x) 0.0 0.0 run function derailed:dev/gen/build
