
# Reads what this tile costs to step onto into '#price_c', as the least-cost
#  flood prices it: ground 1, wood or iron 2, water 4 and rock a thousand
# Positioned on the tile

scoreboard players set #price_c dr_var 1
execute if block ~ ~ ~ #derailed:cost_resource run scoreboard players set #price_c dr_var 2
execute if block ~ ~ ~ #derailed:cost_water run scoreboard players set #price_c dr_var 4
execute if block ~ ~ ~ gray_concrete run scoreboard players set #price_c dr_var 1000
