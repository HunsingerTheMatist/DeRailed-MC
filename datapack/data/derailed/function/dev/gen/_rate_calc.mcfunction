
# Works out what '#gen_cost' over '#gen_route' rails comes to a rail, into
#  '#gen_rate_raw' as it stands and '#gen_rate' with the length counted

# The route is judged by what it costs a rail, since the time the players get is
#  the rails they lay, so a longer way across is not a harder one on its own
# Kept in hundredths of a point a rail, so that it stays a whole number
scoreboard players set #gen_rate_raw dr_var 0
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var = #gen_cost dr_var
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var *= $Hundred dr_const
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var /= #gen_route dr_var

# Then raised a little for every rail past a straight crossing, since a longer
#  section is more rails out of the same supply and more time at the same pace
scoreboard players operation #gen_extra dr_var = #gen_route dr_var
scoreboard players operation #gen_extra dr_var -= #gen_straight dr_var
execute if score #gen_extra dr_var matches ..-1 run scoreboard players set #gen_extra dr_var 0
scoreboard players operation #gen_extra dr_var *= #gen_rail_pen dr_var
scoreboard players add #gen_extra dr_var 100
scoreboard players operation #gen_rate dr_var = #gen_rate_raw dr_var
scoreboard players operation #gen_rate dr_var *= #gen_extra dr_var
scoreboard players operation #gen_rate dr_var /= $Hundred dr_const
