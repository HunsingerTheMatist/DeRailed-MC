
# Finds the cheapest tile of stretch '#sec_s', what it cost into '#sec_bs' and
#  which it is into '#sec_ms', the nearest the route's last tile where two cost
#  the same, and tags it 'dr_rej'

scoreboard players operation #sec_bs dr_var = #sec_inf dr_var
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var run scoreboard players operation #sec_bs dr_var < @s dr_best
execute if score #sec_bs dr_var >= #sec_inf dr_var run return 0

scoreboard players operation #sec_ms dr_var = #sec_inf dr_var
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var if score @s dr_best = #sec_bs dr_var run scoreboard players operation #sec_ms dr_var < @s dr_step
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_step = #sec_ms dr_var run tag @s add dr_rej
