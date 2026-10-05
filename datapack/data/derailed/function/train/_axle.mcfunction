
# Moves this axle on along the track by '$TrainSpeed', onto the next tile once
#  it runs off the end of its own, and stands it where that leaves it
# Run as the axle's marker

scoreboard players operation @s dr_ad += $TrainSpeed dr_config
execute if score @s dr_ad >= @s dr_alen run function derailed:train/_axle_next
function derailed:train/_axle_pos
