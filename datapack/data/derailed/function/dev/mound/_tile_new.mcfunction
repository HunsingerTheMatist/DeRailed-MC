
# Makes this marker a tile's, holding where on the map it is and whether it is
#  iron, $(block), and tagged 'dr_mring' where it is in the ring round the map;
#  its depth is nothing where it is neither iron nor air, the foot of any mound
#  beside it, and unknown where it is either, since a mound goes on through air
# Run as the new marker, on its tile

tag @s add dr_mt
scoreboard players operation @s dr_mx = #mi dr_var
scoreboard players operation @s dr_mz = #mj dr_var
execute if score #mi dr_var matches ..-1 run tag @s add dr_mring
execute if score #mj dr_var matches ..-1 run tag @s add dr_mring
execute if score #mi dr_var = #mw dr_var run tag @s add dr_mring
execute if score #mj dr_var = #mhh dr_var run tag @s add dr_mring
$execute store success score @s dr_mi if block ~ ~ ~ $(block)
scoreboard players set @s dr_md 0
execute if score @s dr_mi matches 1 run scoreboard players set @s dr_md -1
execute if block ~ ~ ~ air run scoreboard players set @s dr_md -1
