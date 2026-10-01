
# Lays the mining marker for this tree or iron tile where its large version's
#  northwestern block stands, two below the ground, tagged 'dr_mine' and
#  'dr_mine_wood' or 'dr_mine_iron', and 'dr_station_near' where it is one of
#  the ten tiles round the station's two-tile building, from a column west of
#  it to one east and a row north of it to one south
# Run as the tile's marker, at it, with the building's western tile in
#  '#big_ax' and '#big_az'

scoreboard players set #big_near dr_temp 0
scoreboard players operation #big_t dr_temp = @s dr_bx
scoreboard players operation #big_t dr_temp -= #big_ax dr_temp
scoreboard players operation #big_u dr_temp = @s dr_bz
scoreboard players operation #big_u dr_temp -= #big_az dr_temp
execute if score #big_t dr_temp matches -1..2 if score #big_u dr_temp matches -1..1 run scoreboard players set #big_near dr_temp 1

scoreboard players set #big_kind dr_temp 0
execute if entity @s[tag=dr_big_iron] run scoreboard players set #big_kind dr_temp 1
execute summon marker run function derailed:dev/big/_mine_tags
