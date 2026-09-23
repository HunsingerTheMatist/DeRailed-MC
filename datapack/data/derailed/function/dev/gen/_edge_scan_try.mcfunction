
# Takes row $(row) of column $(col) if it is not rock

$execute if block ~$(col) ~ ~$(row) gray_concrete run return fail
$scoreboard players set #edge_row dr_var $(row)
return 1
