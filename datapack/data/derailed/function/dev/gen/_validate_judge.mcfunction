
# Judges the route the section has settled on: what it costs a rail, and
#  whether that and its pinching make the section usable, left in '#gen_valid'
# Positioned at the section's corner

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

# A route outside the tier's band is a reroll, unless the tier's band is being
#  measured; and hard wants the train pinched somewhere, so a route that never
#  does is a reroll like a cheap one
scoreboard players set #gen_rate_ok dr_var 0
execute if score #gen_rate dr_var >= #gen_rate_min dr_var if score #gen_rate dr_var <= #gen_rate_max dr_var run scoreboard players set #gen_rate_ok dr_var 1
execute if score #gen_rate_free dr_var matches 1 run scoreboard players set #gen_rate_ok dr_var 1
scoreboard players set #gen_valid dr_var 0
execute if score #gen_reached dr_var matches 1 if score #gen_rate_ok dr_var matches 1 if score #gen_pinch dr_var >= #gen_pinch_min dr_var run scoreboard players set #gen_valid dr_var 1
