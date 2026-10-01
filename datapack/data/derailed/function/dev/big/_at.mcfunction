
# Starts the large version's random sequence over from seed $(seed), then builds
#  it from the section whose corner is $(x) 15 0

$random reset derailed:terrain $(seed) false false
$execute positioned $(x) 15 0 run function derailed:dev/big/_go
