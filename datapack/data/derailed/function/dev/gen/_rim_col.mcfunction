
# Counts this column's tiles into zone $(z) and moves east, ten columns in all
# Positioned on the column's northern tile

scoreboard players set #rim_z dr_var 0
$function derailed:dev/gen/_rim_row {z:$(z)}
scoreboard players add #rim_n dr_var 1
$execute if score #rim_n dr_var matches ..9 positioned ~1 ~ ~ run function derailed:dev/gen/_rim_col {z:$(z)}
