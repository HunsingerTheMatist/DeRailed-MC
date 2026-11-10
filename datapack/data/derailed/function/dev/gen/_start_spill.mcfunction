
# Grows the first section's start station's ground out round it: a region of
#  ground from the three points the scatter picked on it ('_start_mids'),
#  which reaches every tile next to the station, along its two long sides and
#  its eastern end, on the wave it would from the nearest of them, a straight
#  step 5 waves and a diagonal 7, so it takes a tile wherever a point is nearer
#  than any seed
# The station stands in the way of growth, so the region starts on those tiles
#  instead of in it, each waiting for its wave; a tile already taken is passed
#  over
# Takes $(entry), the station's rail row
# Positioned at the section's corner

$execute positioned ~0 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:0,z:-2}
$execute positioned ~1 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:1,z:-2}
$execute positioned ~2 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:2,z:-2}
$execute positioned ~3 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:3,z:-2}
$execute positioned ~4 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:4,z:-2}
$execute positioned ~5 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:5,z:-2}
$execute positioned ~6 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:6,z:-2}
$execute positioned ~7 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:7,z:-2}
$execute positioned ~8 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:8,z:-2}
$execute positioned ~9 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:9,z:-2}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~-2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:-2}
$execute positioned ~0 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:0,z:4}
$execute positioned ~1 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:1,z:4}
$execute positioned ~2 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:2,z:4}
$execute positioned ~3 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:3,z:4}
$execute positioned ~4 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:4,z:4}
$execute positioned ~5 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:5,z:4}
$execute positioned ~6 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:6,z:4}
$execute positioned ~7 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:7,z:4}
$execute positioned ~8 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:8,z:4}
$execute positioned ~9 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:9,z:4}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~4 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:4}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~-1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:-1}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~0 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:0}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:1}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~2 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:2}
$execute positioned ~10 ~ ~$(entry) positioned ~ ~ ~3 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_spill_tile {x:10,z:3}
