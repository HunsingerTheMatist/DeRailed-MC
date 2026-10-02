
# Tags this mining marker with the tile's kind, '#big_kind' 0 wood or 1 iron,
#  and 'dr_station_near' where '#big_near' is set, and starts it on stage 1;
#  an iron tile takes the variant of its later stages at random, and a tree
#  takes the variant it is placed as
# Run as the new marker

tag @s add dr_mine
execute if score #big_kind dr_temp matches 0 run tag @s add dr_mine_wood
execute if score #big_kind dr_temp matches 1 run tag @s add dr_mine_iron
execute if score #big_near dr_temp matches 1 run tag @s add dr_station_near
scoreboard players set @s dr_mine_stage 1
execute if score #big_kind dr_temp matches 1 store result score @s dr_mine_variant run random value 1..5 derailed:terrain
