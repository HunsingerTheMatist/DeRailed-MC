
# Searches off the route from stretch '#sec_s', from every tile of it at or past
#  the one it is joined at, so that the second route never walks back over the
#  first
# Positioned at the section's corner

execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var if score @s dr_step >= #sec_ms dr_var run tag @s add dr_src
function derailed:dev/gen/_sec_bfs
tag @e[type=marker,tag=dr_src,distance=0..] remove dr_src
