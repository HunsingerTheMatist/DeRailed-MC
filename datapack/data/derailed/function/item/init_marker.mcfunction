# Promote a marker's baked entity_data into scores. Run as the marker
#
# Only ownership is promoted. What is being placed comes from the placing
#  player, who is the source of truth for it

execute store result score @s dr_player_id run data get entity @s data.owner
tag @s add dr_init
