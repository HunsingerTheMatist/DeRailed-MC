
# Lays the way found down on the flood's layer as a flood would have left it,
#  every tile pointing to the one after it toward the entry and the entry
#  white, a stretch at a time from the entry back to the route's last tile,
#  and counts the longest detour into '#sec_detour_max'
# Positioned at the section's corner

fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~32 ~2 ~-1 ~32 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~32 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~32 ~2 ~16 gray_stained_glass replace air strict

execute as @e[type=marker,tag=dr_rp,distance=0..] if score @s dr_step = #sec_n dr_var at @s run setblock ~ ~2 ~ white_stained_glass strict
scoreboard players operation #sec_t dr_var = #sec_last dr_var
scoreboard players operation #sec_end dr_var = #sec_n dr_var
scoreboard players set #sec_detour_max dr_var 0
scoreboard players set #sec_guard dr_var 20
function derailed:dev/gen/_sec_build_step
