
# Starts this tile growing as the void on wave $(wake), as a region carried over
#  the seam would, at once where that is now
# Positioned at the tile

scoreboard players set #gen_id dr_var 31
$scoreboard players set #seam_wake dr_var $(wake)
execute if score #seam_wake dr_var matches ..0 run return run function derailed:dev/gen/_seam_now
function derailed:dev/gen/_seam_later
