
# Lays a tile's rails: a rail on its middle block, straight or turning from the
#  edge it comes in by to the edge it leaves by, and a powered rail on each of
#  those two edges, coming in going way '#din' and leaving going way '#dout'
# Positioned at the tile's northwestern block, on the ground

# The edge it comes in by faces back the way in
scoreboard players operation #a dr_temp = #din dr_temp
scoreboard players add #a dr_temp 2
scoreboard players operation #a dr_temp %= $Four dr_const

execute if score #a dr_temp matches 0 run setblock ~1 ~ ~ powered_rail[shape=north_south] strict
execute if score #a dr_temp matches 1 run setblock ~2 ~ ~1 powered_rail[shape=east_west] strict
execute if score #a dr_temp matches 2 run setblock ~1 ~ ~2 powered_rail[shape=north_south] strict
execute if score #a dr_temp matches 3 run setblock ~ ~ ~1 powered_rail[shape=east_west] strict
execute if score #dout dr_temp matches 0 run setblock ~1 ~ ~ powered_rail[shape=north_south] strict
execute if score #dout dr_temp matches 1 run setblock ~2 ~ ~1 powered_rail[shape=east_west] strict
execute if score #dout dr_temp matches 2 run setblock ~1 ~ ~2 powered_rail[shape=north_south] strict
execute if score #dout dr_temp matches 3 run setblock ~ ~ ~1 powered_rail[shape=east_west] strict

execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 0 run setblock ~1 ~ ~1 rail[shape=north_south] strict
execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 2 run setblock ~1 ~ ~1 rail[shape=north_south] strict
execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 1 run setblock ~1 ~ ~1 rail[shape=east_west] strict
execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 3 run setblock ~1 ~ ~1 rail[shape=east_west] strict
execute if score #a dr_temp matches 0 if score #dout dr_temp matches 1 run setblock ~1 ~ ~1 rail[shape=north_east] strict
execute if score #a dr_temp matches 1 if score #dout dr_temp matches 0 run setblock ~1 ~ ~1 rail[shape=north_east] strict
execute if score #a dr_temp matches 0 if score #dout dr_temp matches 3 run setblock ~1 ~ ~1 rail[shape=north_west] strict
execute if score #a dr_temp matches 3 if score #dout dr_temp matches 0 run setblock ~1 ~ ~1 rail[shape=north_west] strict
execute if score #a dr_temp matches 2 if score #dout dr_temp matches 1 run setblock ~1 ~ ~1 rail[shape=south_east] strict
execute if score #a dr_temp matches 1 if score #dout dr_temp matches 2 run setblock ~1 ~ ~1 rail[shape=south_east] strict
execute if score #a dr_temp matches 2 if score #dout dr_temp matches 3 run setblock ~1 ~ ~1 rail[shape=south_west] strict
execute if score #a dr_temp matches 3 if score #dout dr_temp matches 2 run setblock ~1 ~ ~1 rail[shape=south_west] strict
