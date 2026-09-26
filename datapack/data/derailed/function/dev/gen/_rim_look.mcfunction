
# Counts what every tile of the section's first ten columns, zone 'a', and its
#  last ten, zone 'b', is into 'dr_rim', for the report
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid and the first route's regions are tagged

function derailed:dev/gen/_rim_zero {z:a}
function derailed:dev/gen/_rim_zero {z:b}
scoreboard players set #rim_n dr_var 0
function derailed:dev/gen/_rim_col {z:a}
scoreboard players set #rim_n dr_var 0
execute positioned ~22 ~ ~ run function derailed:dev/gen/_rim_col {z:b}
