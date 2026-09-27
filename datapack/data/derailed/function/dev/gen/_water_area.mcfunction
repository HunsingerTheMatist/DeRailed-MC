
# Marks one layer down every tile of land within '#gen_water_reach' steps of
#  water, walking out from every tile of water between column $(xs) and this
#  section's last, inside glass one tile out all round so that the walk stays
#  within them
# Takes $(xs), the westernmost column, and $(xw), the one west of it
# Positioned at the section's corner, on the visible layer

$fill ~$(xw) ~-1 ~-1 ~32 ~-1 ~16 air strict
$fill ~$(xw) ~-1 ~-1 ~$(xw) ~-1 ~16 gray_stained_glass strict
fill ~32 ~-1 ~-1 ~32 ~-1 ~16 gray_stained_glass strict
$fill ~$(xw) ~-1 ~-1 ~32 ~-1 ~-1 gray_stained_glass strict
$fill ~$(xw) ~-1 ~16 ~32 ~-1 ~16 gray_stained_glass strict

scoreboard players set #wr_next dr_var 0
$scoreboard players set #wr_x dr_var $(xs)
$execute positioned ~$(xs) ~ ~ run function derailed:dev/gen/_water_seed_col

scoreboard players set #wr_k dr_var 0
function derailed:dev/gen/_water_wave
kill @e[type=marker,tag=dr_wq,distance=0..]
