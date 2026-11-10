
# Puts in '#gw' the waves growth takes to go '#gx' columns and '#gz' rows, 5 a
#  straight step and 7 a diagonal one

execute if score #gx dr_temp matches ..-1 run scoreboard players operation #gx dr_temp *= $NegOne dr_const
execute if score #gz dr_temp matches ..-1 run scoreboard players operation #gz dr_temp *= $NegOne dr_const
scoreboard players operation #gw dr_temp = #gx dr_temp
scoreboard players operation #gw dr_temp > #gz dr_temp
scoreboard players operation #gx dr_temp < #gz dr_temp
scoreboard players operation #gw dr_temp *= $Five dr_const
scoreboard players operation #gw dr_temp += #gx dr_temp
scoreboard players operation #gw dr_temp += #gx dr_temp
