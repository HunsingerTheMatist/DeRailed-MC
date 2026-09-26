
# Counts this tile into zone $(z) and moves south to the column's end

$function derailed:dev/gen/_rim_tile {z:$(z)}
scoreboard players add #rim_z dr_var 1
$execute if score #rim_z dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_rim_row {z:$(z)}
