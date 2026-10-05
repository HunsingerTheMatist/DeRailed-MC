
# Sets the crafting wagon on the line between its axles, midway, facing its
#  back axle, since an item display turns its model about; its shulker and its
#  interaction ride it; then turns its model that way
# Facing a square way, it goes by plain offsets, the same distance turned to
#  that way
# Run as the crafting wagon's item display, with '#tid' its piece

execute at @n[type=marker,tag=dr_axle_here,tag=dr_axle_back,distance=0..] facing entity @n[type=marker,tag=dr_axle_here,tag=dr_axle_front,distance=0..] feet positioned ^ ^ ^0.6 run tp @s ~ ~ ~ facing entity @n[type=marker,tag=dr_axle_here,tag=dr_axle_back,distance=0..] feet
function derailed:train/_square
execute if score #sq dr_temp matches 0 at @n[type=marker,tag=dr_axle_here,tag=dr_axle_back,distance=0..] run tp @s ~ ~ ~-0.6
execute if score #sq dr_temp matches 1 at @n[type=marker,tag=dr_axle_here,tag=dr_axle_back,distance=0..] run tp @s ~0.6 ~ ~
execute if score #sq dr_temp matches 2 at @n[type=marker,tag=dr_axle_here,tag=dr_axle_back,distance=0..] run tp @s ~ ~ ~0.6
execute if score #sq dr_temp matches 3 at @n[type=marker,tag=dr_axle_here,tag=dr_axle_back,distance=0..] run tp @s ~-0.6 ~ ~

# Its wheels at their axles, ahead toward its front, which it faces away from
execute at @s rotated as @s positioned ^ ^0.45 ^-0.6 as @e[type=item_display,tag=dr_wheel_1,distance=0..] if score @s dr_tid = #tid dr_temp run tp @s ~ ~ ~
execute at @s rotated as @s positioned ^ ^0.45 ^0.6 as @e[type=item_display,tag=dr_wheel_2,distance=0..] if score @s dr_tid = #tid dr_temp run tp @s ~ ~ ~

function derailed:train/_turn
