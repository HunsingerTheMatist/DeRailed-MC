
# Searches off the route from stretch '#sec_s', from every tile of it at or past
#  the one it is joined at, so that the second route never walks back over the
#  first, and keeps the ways the search reached its tiles from on a layer of
#  their own, six above plus the stretch's number, for the detours to be laid
#  by
# Positioned at the section's corner

execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var if score @s dr_step >= #sec_ms dr_var run tag @s add dr_src
function derailed:dev/gen/_sec_bfs
tag @e[type=marker,tag=dr_src,distance=0..] remove dr_src

scoreboard players operation #sec_y dr_var = #sec_s dr_var
scoreboard players add #sec_y dr_var 6
execute store result storage derailed:gen sk.y int 1 run scoreboard players get #sec_y dr_var
function derailed:dev/gen/_sec_keep with storage derailed:gen sk
