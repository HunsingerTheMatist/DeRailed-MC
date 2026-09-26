
# Tags 'dr_rp_x' the first route's tiles the second route may not stand on,
#  the pinched ones but the route's two ends, which both routes share, counts
#  the route's last tile, the entry, into '#sec_n', and splits the tiles it may
#  stand on into stretches, numbered in 'dr_str' from the route's last tile on,
#  a pinched tile ending one stretch and the next tile it may stand on starting
#  another, the stretch the entry is in being '#sec_last'

tag @e[type=marker,tag=dr_rp,distance=0..] remove dr_rp_x
execute as @e[type=marker,tag=dr_rp,distance=0..] at @s if entity @n[type=marker,tag=dr_pinch,distance=..0.4] run tag @s add dr_rp_x
scoreboard players set #sec_n dr_var 0
execute as @e[type=marker,tag=dr_rp,distance=0..] run scoreboard players operation #sec_n dr_var > @s dr_step
tag @e[type=marker,tag=dr_rp,scores={dr_step=0},distance=0..] remove dr_rp_x
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_step = #sec_n dr_var run tag @s remove dr_rp_x

scoreboard players set @e[type=marker,tag=dr_rp_x,distance=0..] dr_str -1
scoreboard players set #sec_last dr_var -1
scoreboard players set #sec_after_x dr_var 1
scoreboard players set #sec_i dr_var 0
function derailed:dev/gen/_sec_stretch
