# Verify the held item still matches the carried record. Run as the player
#
# The record is the source of truth, so any disagreement is settled by redrawing
#  the hand from it rather than by believing the inventory

execute store result score #hand_count dr_temp run execute if items entity @s weapon.mainhand panda_spawn_egg
scoreboard players set #hand_type dr_temp 0
execute store result score #hand_type dr_temp run data get entity @s SelectedItem.components."minecraft:custom_data".item

scoreboard players set #hand_ok dr_temp 0
execute if score #hand_count dr_temp = @s dr_count if score #hand_type dr_temp = @s dr_item run scoreboard players set #hand_ok dr_temp 1
execute if score @s dr_count matches 0 if score #hand_count dr_temp matches 0 run scoreboard players set #hand_ok dr_temp 1

execute if score #hand_ok dr_temp matches 0 run tellraw @a [{text:"[inv] ",color:"gold"},{selector:"@s"},{text:" hand "},{score:{name:"#hand_count",objective:"dr_temp"},color:"red"},{text:" of type "},{score:{name:"#hand_type",objective:"dr_temp"},color:"red"},{text:" but record says "},{score:{name:"@s",objective:"dr_count"},color:"green"},{text:" of type "},{score:{name:"@s",objective:"dr_item"},color:"green"}]
execute if score #hand_ok dr_temp matches 0 run function derailed:player/fix_items

# If the map check is enabled and the offhand does not hold exactly the one map,
#  put it back
execute unless score $MapEnabled dr_config matches 1 run return fail
execute store result score #map_total dr_temp run clear @s filled_map 0
scoreboard players set #map_ok dr_temp 0
execute if items entity @s weapon.offhand filled_map run scoreboard players set #map_ok dr_temp 1
execute unless score #map_total dr_temp matches 1 run scoreboard players set #map_ok dr_temp 0
execute if score #map_ok dr_temp matches 0 run tellraw @a [{text:"[inv] ",color:"gold"},{selector:"@s"},{text:" map misplaced, total "},{score:{name:"#map_total",objective:"dr_temp"},color:"red"}]
execute if score #map_ok dr_temp matches 0 run function derailed:player/fix_map
