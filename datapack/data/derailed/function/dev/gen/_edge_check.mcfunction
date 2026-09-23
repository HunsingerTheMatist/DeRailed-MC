
# Leaves the row alone unless the tile at column $(col), row $(row) is rock

$execute unless block ~$(col) ~ ~$(row) gray_concrete run return 0
function derailed:dev/gen/_edge_move
