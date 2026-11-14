
# Finds the second chest's column for this first one, tagged 'dr_big_second':
#  one of the pool's on another region, '#ch_rad' or more blocks from it across
#  the ground, taken at random and tried one at a time as the first is; fails
#  where none fits
# Run as the first chest's column

scoreboard players operation #ch_px dr_temp = @s dr_bpx
scoreboard players operation #ch_pz dr_temp = @s dr_bpz
scoreboard players operation #ch_pg dr_temp = @s dr_breg
scoreboard players operation #ch_rr dr_temp = #ch_rad dr_temp
scoreboard players operation #ch_rr dr_temp *= #ch_rad dr_temp
tag @e[type=marker,tag=dr_big_pool2,distance=0..] remove dr_big_pool2
tag @e[type=marker,tag=dr_big_tried2,distance=0..] remove dr_big_tried2
execute as @e[type=marker,tag=dr_big_pool,distance=0..] unless score @s dr_breg = #ch_pg dr_temp run function derailed:dev/big/_chest_far
return run function derailed:dev/big/_chest_second_draw
