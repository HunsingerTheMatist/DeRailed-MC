
# Tags this column 'dr_big_pool2' where it stands '#ch_rad' or more blocks
#  across the ground from the first chest's, at '#ch_px' '#ch_pz'
# Run as the column's marker

scoreboard players operation #ch_dx dr_temp = @s dr_bpx
scoreboard players operation #ch_dx dr_temp -= #ch_px dr_temp
scoreboard players operation #ch_dx dr_temp *= #ch_dx dr_temp
scoreboard players operation #ch_dz dr_temp = @s dr_bpz
scoreboard players operation #ch_dz dr_temp -= #ch_pz dr_temp
scoreboard players operation #ch_dz dr_temp *= #ch_dz dr_temp
scoreboard players operation #ch_dx dr_temp += #ch_dz dr_temp
execute if score #ch_dx dr_temp >= #ch_rr dr_temp run tag @s add dr_big_pool2
