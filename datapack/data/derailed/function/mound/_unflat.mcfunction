
# Gives the tile a spiking corner, one of the four taken at random, where its
#  nine columns '#mh0' to '#mh8' would all come out the same height, so no tile
#  is laid flat: the height each would come out at is its pixels to the nearest
#  step the kind's tops come in, half a block for rock and a quarter for iron

scoreboard players set #mstep dr_temp 8
execute if score #mound_kind dr_arg matches 0 run scoreboard players set #mstep dr_temp 4
scoreboard players operation #mhalf dr_temp = #mstep dr_temp
scoreboard players operation #mhalf dr_temp /= #m2 dr_temp

scoreboard players operation #ml dr_temp = #mh0 dr_temp
scoreboard players operation #ml dr_temp += #mhalf dr_temp
scoreboard players operation #ml dr_temp /= #mstep dr_temp
scoreboard players operation #mlv dr_temp = #mh1 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh2 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh3 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh4 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh5 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh6 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh7 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0
scoreboard players operation #mlv dr_temp = #mh8 dr_temp
scoreboard players operation #mlv dr_temp += #mhalf dr_temp
scoreboard players operation #mlv dr_temp /= #mstep dr_temp
execute unless score #mlv dr_temp = #ml dr_temp run return 0

# The spiking corner is the two by two columns at one of the tile's corners,
#  northwest, northeast, southwest or southeast, as '_block' has it
scoreboard players set #mlo dr_temp 0
scoreboard players set #mhi dr_temp 3
function derailed:mound/_rand
execute if score #mj dr_temp matches 0 run scoreboard players operation #mh0 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 0 run scoreboard players operation #mh1 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 0 run scoreboard players operation #mh3 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 0 run scoreboard players operation #mh4 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 1 run scoreboard players operation #mh1 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 1 run scoreboard players operation #mh2 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 1 run scoreboard players operation #mh4 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 1 run scoreboard players operation #mh5 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 2 run scoreboard players operation #mh3 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 2 run scoreboard players operation #mh4 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 2 run scoreboard players operation #mh6 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 2 run scoreboard players operation #mh7 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 3 run scoreboard players operation #mh4 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 3 run scoreboard players operation #mh5 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 3 run scoreboard players operation #mh7 dr_temp += #mspkpx dr_temp
execute if score #mj dr_temp matches 3 run scoreboard players operation #mh8 dr_temp += #mspkpx dr_temp
scoreboard players operation #mh0 dr_temp < #mmax dr_temp
scoreboard players operation #mh1 dr_temp < #mmax dr_temp
scoreboard players operation #mh2 dr_temp < #mmax dr_temp
scoreboard players operation #mh3 dr_temp < #mmax dr_temp
scoreboard players operation #mh4 dr_temp < #mmax dr_temp
scoreboard players operation #mh5 dr_temp < #mmax dr_temp
scoreboard players operation #mh6 dr_temp < #mmax dr_temp
scoreboard players operation #mh7 dr_temp < #mmax dr_temp
scoreboard players operation #mh8 dr_temp < #mmax dr_temp
