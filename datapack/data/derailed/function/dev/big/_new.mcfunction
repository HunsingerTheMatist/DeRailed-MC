
# Makes this marker the tile's, tagged with what its large version is: a tree
#  on wood, a mound on iron or rock, a lake on water, a river on river the way
#  its glaze points, one cut through rock without a glaze as 'dr_big_cut' until
#  its way is worked out, the void the map starts at as 'dr_big_void', and
#  ground on anything else, the stations' buildings among it; the western tile
#  of the station's building at the section's end is tagged 'dr_big_station'
#  as well, and that of the first section's start station's building, nearer
#  its western edge, 'dr_big_start'; every tile of a station is tagged
#  'dr_big_prefab' too; keeps the tile's region in 'dr_breg', -1
#  where it is no region's; then moves it to where the tile's large version
#  goes
# Run as the new marker, on the tile

tag @s add dr_big
scoreboard players operation @s dr_bx = #big_x dr_temp
scoreboard players operation @s dr_bz = #big_z dr_temp
scoreboard players set #gen_id dr_var -1
execute positioned ~ ~-15 ~ run function derailed:dev/gen/_read_id
scoreboard players operation @s dr_breg = #gen_id dr_var
execute if block ~ ~ ~ brown_concrete run tag @s add dr_big_tree
execute if block ~ ~ ~ light_gray_concrete run tag @s add dr_big_iron
execute if block ~ ~ ~ gray_concrete unless block ~ ~-15 ~ obsidian run tag @s add dr_big_rock
execute if block ~ ~ ~ blue_concrete run tag @s add dr_big_lake
execute if block ~ ~ ~ light_blue_concrete run function derailed:dev/big/_river
execute if block ~ ~ ~ black_concrete if block ~ ~-15 ~ obsidian run tag @s add dr_big_void
execute if block ~ ~-15 ~ #derailed:prefab if entity @s[tag=!dr_big_void] run tag @s add dr_big_prefab
execute if entity @s[tag=!dr_big_tree,tag=!dr_big_iron,tag=!dr_big_rock,tag=!dr_big_lake,tag=!dr_big_river,tag=!dr_big_void] run tag @s add dr_big_ground
execute if score #big_x dr_temp matches 16.. if block ~ ~-15 ~ obsidian unless block ~-1 ~-15 ~ obsidian run tag @s add dr_big_station
execute if score #big_x dr_temp matches ..15 if block ~ ~ ~ gray_concrete if block ~ ~-15 ~ obsidian unless block ~-1 ~-15 ~ obsidian run tag @s add dr_big_start

scoreboard players operation #big_t dr_temp = #big_x dr_temp
scoreboard players operation #big_t dr_temp *= #big_3 dr_temp
execute store result entity @s Pos[0] double 1 run scoreboard players add #big_t dr_temp 1100
data modify entity @s Pos[1] set value 13.0d
scoreboard players operation #big_t dr_temp = #big_z dr_temp
execute store result entity @s Pos[2] double 1 run scoreboard players operation #big_t dr_temp *= #big_3 dr_temp
