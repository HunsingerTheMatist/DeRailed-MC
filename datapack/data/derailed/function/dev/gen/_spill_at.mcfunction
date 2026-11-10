
# Leaves this tile for the start station's ground to reach on wave $(wake), as
#  a region carried over the seam waits, growing as ground; one that loses its
#  tile first is counted with the seam's
# Positioned at the tile

scoreboard players set #gen_id dr_var 26
$scoreboard players set #seam_wake dr_var $(wake)
function derailed:dev/gen/_seam_later
