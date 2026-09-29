
# Works the stretches out again joining each as near the route's last tile as
#  it was reached, and leaves '#sec_fb' set while its joins stand, since
#  building the way searches again from the same tiles
# Positioned at the section's corner

scoreboard players set #sec_fb dr_var 1
function derailed:dev/gen/_sec_dp
