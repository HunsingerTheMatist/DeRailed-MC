
# Tags this mining marker with the tile's kind, '#big_kind' 0 wood or 1 iron,
#  and 'dr_station_near' where '#big_near' is set
# Run as the new marker

tag @s add dr_mine
execute if score #big_kind dr_temp matches 0 run tag @s add dr_mine_wood
execute if score #big_kind dr_temp matches 1 run tag @s add dr_mine_iron
execute if score #big_near dr_temp matches 1 run tag @s add dr_station_near
