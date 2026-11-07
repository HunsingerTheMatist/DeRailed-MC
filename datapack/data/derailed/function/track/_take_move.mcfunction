# Moves the new take interactions, tagged 'dr_take_new', onto the bottom of
#  this block, $(xa) $(za) and $(xb) $(zb) across it
# Run at the middle of the end of the track's middle block

$tp @n[type=interaction,tag=dr_take_new,tag=dr_take_a,distance=0..] ~$(xa) ~-0.5 ~$(za)
$tp @n[type=interaction,tag=dr_take_new,tag=dr_take_b,distance=0..] ~$(xb) ~-0.5 ~$(zb)
