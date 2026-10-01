
# Makes this marker a tile's, holding where on the map it is and whether it is
#  of the kind, and tagged 'dr_mound_ring' where it is in the ring round the
#  map; its depth is nothing where it is neither the kind nor air, the foot of
#  any mound beside it, and unknown where it is either, since a mound goes on
#  through air
# Run as the new marker, on its tile

tag @s add dr_mound_t
scoreboard players operation @s dr_mx = #mi dr_temp
scoreboard players operation @s dr_mz = #mj dr_temp
execute if score #mi dr_temp matches ..-1 run tag @s add dr_mound_ring
execute if score #mj dr_temp matches ..-1 run tag @s add dr_mound_ring
execute if score #mi dr_temp = #mound_w dr_arg run tag @s add dr_mound_ring
execute if score #mj dr_temp = #mound_h dr_arg run tag @s add dr_mound_ring

scoreboard players set @s dr_mi 0
execute if score #mound_kind dr_arg matches 0 if block ~ ~ ~ light_gray_concrete run scoreboard players set @s dr_mi 1
execute if score #mound_kind dr_arg matches 1 if block ~ ~ ~ gray_concrete run scoreboard players set @s dr_mi 1
scoreboard players set @s dr_md 0
execute if score @s dr_mi matches 1 run scoreboard players set @s dr_md -1
execute if block ~ ~ ~ air run scoreboard players set @s dr_md -1
