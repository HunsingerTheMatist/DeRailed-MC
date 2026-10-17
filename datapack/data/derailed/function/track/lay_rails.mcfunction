
# Lays a tile's rails: a rail on its middle block, straight or turning from the
#  edge it comes in by to the edge it leaves by, and a powered rail on each of
#  those two edges, coming in going way '#din' and leaving going way '#dout'
# Every rail is an iron trapdoor, which a hand cannot open, drawn as its rail by
#  the resource pack:
#    powered=false facing=north    straight, north to south
#    powered=false facing=east     straight, east to west
#    powered=false facing=south    powered rail
#    powered=true  facing=north    turning south to east
#    powered=true  facing=east     turning south to west
#    powered=true  facing=south    turning north to west
#    powered=true  facing=west     turning north to east
#  Nothing may give them a block update, which would set 'powered' back
# Positioned at the tile's northwestern block, on the ground

# The edge it comes in by faces back the way in
scoreboard players operation #a dr_temp = #din dr_temp
scoreboard players add #a dr_temp 2
scoreboard players operation #a dr_temp %= $Four dr_const

execute if score #a dr_temp matches 0 run setblock ~1 ~ ~ iron_trapdoor[facing=south,powered=false] strict
execute if score #a dr_temp matches 1 run setblock ~2 ~ ~1 iron_trapdoor[facing=south,powered=false] strict
execute if score #a dr_temp matches 2 run setblock ~1 ~ ~2 iron_trapdoor[facing=south,powered=false] strict
execute if score #a dr_temp matches 3 run setblock ~ ~ ~1 iron_trapdoor[facing=south,powered=false] strict
execute if score #dout dr_temp matches 0 run setblock ~1 ~ ~ iron_trapdoor[facing=south,powered=false] strict
execute if score #dout dr_temp matches 1 run setblock ~2 ~ ~1 iron_trapdoor[facing=south,powered=false] strict
execute if score #dout dr_temp matches 2 run setblock ~1 ~ ~2 iron_trapdoor[facing=south,powered=false] strict
execute if score #dout dr_temp matches 3 run setblock ~ ~ ~1 iron_trapdoor[facing=south,powered=false] strict

execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 0 run setblock ~1 ~ ~1 iron_trapdoor[facing=north,powered=false] strict
execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 2 run setblock ~1 ~ ~1 iron_trapdoor[facing=north,powered=false] strict
execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 1 run setblock ~1 ~ ~1 iron_trapdoor[facing=east,powered=false] strict
execute if score #din dr_temp = #dout dr_temp if score #din dr_temp matches 3 run setblock ~1 ~ ~1 iron_trapdoor[facing=east,powered=false] strict
execute if score #a dr_temp matches 0 if score #dout dr_temp matches 1 run setblock ~1 ~ ~1 iron_trapdoor[facing=west,powered=true] strict
execute if score #a dr_temp matches 1 if score #dout dr_temp matches 0 run setblock ~1 ~ ~1 iron_trapdoor[facing=west,powered=true] strict
execute if score #a dr_temp matches 0 if score #dout dr_temp matches 3 run setblock ~1 ~ ~1 iron_trapdoor[facing=south,powered=true] strict
execute if score #a dr_temp matches 3 if score #dout dr_temp matches 0 run setblock ~1 ~ ~1 iron_trapdoor[facing=south,powered=true] strict
execute if score #a dr_temp matches 2 if score #dout dr_temp matches 1 run setblock ~1 ~ ~1 iron_trapdoor[facing=north,powered=true] strict
execute if score #a dr_temp matches 1 if score #dout dr_temp matches 2 run setblock ~1 ~ ~1 iron_trapdoor[facing=north,powered=true] strict
execute if score #a dr_temp matches 2 if score #dout dr_temp matches 3 run setblock ~1 ~ ~1 iron_trapdoor[facing=east,powered=true] strict
execute if score #a dr_temp matches 3 if score #dout dr_temp matches 2 run setblock ~1 ~ ~1 iron_trapdoor[facing=east,powered=true] strict
