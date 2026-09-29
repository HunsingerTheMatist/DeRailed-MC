
# Finds the tile stretch '#sec_s' is joined at, what reaching it cost into
#  '#sec_bs' and which it is into '#sec_ms', and tags it 'dr_rej': the
#  cheapest of the stretch's tiles, the nearest the route's last tile where
#  two cost the same, or with '#sec_fb' set the nearest the route's last tile
#  of those reached at all, so that every detour able to leave the stretch
#  can be searched from

scoreboard players operation #sec_bs dr_var = #sec_inf dr_var
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var run scoreboard players operation #sec_bs dr_var < @s dr_best
execute if score #sec_bs dr_var >= #sec_inf dr_var run return 0

scoreboard players operation #sec_ms dr_var = #sec_inf dr_var
execute if score #sec_fb dr_var matches 0 as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var if score @s dr_best = #sec_bs dr_var run scoreboard players operation #sec_ms dr_var < @s dr_step
execute if score #sec_fb dr_var matches 1 as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_str = #sec_s dr_var if score @s dr_best < #sec_inf dr_var run scoreboard players operation #sec_ms dr_var < @s dr_step
execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_step = #sec_ms dr_var run tag @s add dr_rej
execute if score #sec_fb dr_var matches 1 as @e[type=marker,tag=dr_rej,distance=0..] if score @s dr_str = #sec_s dr_var run scoreboard players operation #sec_bs dr_var = @s dr_best
