
# Clears this tile down to the ground from y17, the top of the tallest tree or
#  iron third stage, puts the station's overhang back over it where it
#  reaches, yields the tile's resource on the middle of it and retires the
#  marker
# Run as the tile's mining marker, at it

fill ~ ~2 ~ ~2 ~4 ~2 air strict
execute if entity @s[tag=dr_station_near] run function derailed:station/merge

scoreboard players set #curr_item_count dr_arg 1
execute if entity @s[tag=dr_mine_wood] run scoreboard players operation #curr_item dr_arg = $Wood dr_const
execute if entity @s[tag=dr_mine_iron] run scoreboard players operation #curr_item dr_arg = $Iron dr_const
scoreboard players set #curr_rotation dr_arg 0
execute positioned ~1.5 ~2 ~1.5 run function derailed:item/place_new
kill @s
