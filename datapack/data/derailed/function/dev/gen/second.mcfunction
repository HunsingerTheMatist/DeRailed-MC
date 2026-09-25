
# Finds the second way across: a route between the same two tiles as the first
#  that keeps off every cell of the first route where the train is pinched, so
#  that the players can always get round the train, and cuts through rock only
#  where nothing better is left, well away from the first route
# It is judged for pinching like the first route and opened up the same way,
#  never for cost, and it is drawn on the route layer in purple, pink where it
#  shares a tile with the first route
# Positioned at the section's corner, once the section has settled on its
#  first route

# A section the first route never got across has nothing to go round
scoreboard players set #sec_reached dr_var 0
scoreboard players set #sec_route dr_var 0
scoreboard players set #sec_wet dr_var 0
fill ~ ~4 ~ ~31 ~4 ~15 air strict
execute if score #gen_reached dr_var matches 0 run return 0

# What the first route came to is kept, since the second is measured with the
#  same figures and the report wants the first's back afterwards
scoreboard players operation #crit_route dr_var = #gen_route dr_var
scoreboard players operation #crit_wet dr_var = #gen_wet dr_var
scoreboard players operation #crit_cost dr_var = #gen_cost dr_var
scoreboard players operation #crit_carved dr_var = #gen_carved dr_var
scoreboard players operation #crit_pinch dr_var = #gen_pinch dr_var
scoreboard players operation #crit_opened dr_var = #gen_opened dr_var

# The first route is copied up a layer, every pinched cell of it marked, and
#  two things drawn round it: a band, white on the tiles beside it, where the
#  second route walks for nothing, and a zone, black out to four steps along
#  the grid from each pinched cell, where rock is never cut for it, light gray
#  where the two fall on the same tile
fill ~ ~3 ~ ~31 ~3 ~15 air strict
clone ~ ~2 ~ ~31 ~2 ~15 ~ ~3 ~ strict filtered red_stained_glass
execute as @e[type=marker,tag=dr_pinch,distance=0..] at @s run setblock ~ ~3 ~ gray_stained_glass strict
data modify storage derailed:gen e.f set value "_second_band_at"
function derailed:dev/gen/_each
data modify storage derailed:gen e.f set value "_second_zone_at"
function derailed:dev/gen/_each

# Both spill past the section's edges, onto air only, and what spilt goes by
#  its colour so that nothing standing out there is touched
fill ~-4 ~3 ~-4 ~35 ~3 ~-1 air replace white_stained_glass strict
fill ~-4 ~3 ~-4 ~35 ~3 ~-1 air replace black_stained_glass strict
fill ~-4 ~3 ~-4 ~35 ~3 ~-1 air replace light_gray_stained_glass strict
fill ~-4 ~3 ~16 ~35 ~3 ~19 air replace white_stained_glass strict
fill ~-4 ~3 ~16 ~35 ~3 ~19 air replace black_stained_glass strict
fill ~-4 ~3 ~16 ~35 ~3 ~19 air replace light_gray_stained_glass strict
fill ~-4 ~3 ~ ~-1 ~3 ~15 air replace white_stained_glass strict
fill ~-4 ~3 ~ ~-1 ~3 ~15 air replace black_stained_glass strict
fill ~-4 ~3 ~ ~-1 ~3 ~15 air replace light_gray_stained_glass strict
fill ~32 ~3 ~ ~35 ~3 ~15 air replace white_stained_glass strict
fill ~32 ~3 ~ ~35 ~3 ~15 air replace black_stained_glass strict
fill ~32 ~3 ~ ~35 ~3 ~15 air replace light_gray_stained_glass strict

scoreboard players set #cost_mode dr_var 1
scoreboard players set #gen_carved dr_var 0
function derailed:dev/gen/_second_pass

# A route that had to cut through rock is found again over what it cut, as
#  the first route is
execute if score #gen_carved dr_var matches 1.. run scoreboard players add #gen_cuts2 dr_var 1
execute if score #gen_carved dr_var matches 1.. run function derailed:dev/gen/_second_pass

scoreboard players set #gen_opened dr_var 0
scoreboard players set #pinch_rounds dr_var 4
execute if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var > #gen_pinch_max dr_var run scoreboard players add #gen_relieved2 dr_var 1
execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_pinch_relieve
execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_no_second dr_var 1

# Where no second way was found, the band it was looked for in is left a
#  layer up, to be looked at: the first route in red, its pinched cells in
#  gray, the free band in white, the no-cut zone in black and light gray
#  where the two meet
execute if score #gen_reached dr_var matches 0 run clone ~ ~3 ~ ~31 ~3 ~15 ~ ~4 ~ strict

# Purple where the second route runs alone, pink where the two share a tile,
#  and the first route back in red everywhere else it runs
data modify storage derailed:gen e.f set value "_second_mark_at"
function derailed:dev/gen/_each
fill ~ ~3 ~ ~31 ~3 ~15 air strict
scoreboard players set #cost_mode dr_var 0

scoreboard players operation #sec_route dr_var = #gen_route dr_var
scoreboard players operation #sec_wet dr_var = #gen_wet dr_var
scoreboard players operation #sec_astray dr_var = #gen_astray dr_var
scoreboard players operation #sec_carved dr_var = #gen_carved dr_var
scoreboard players operation #sec_pinch dr_var = #gen_pinch dr_var
scoreboard players operation #sec_opened dr_var = #gen_opened dr_var
scoreboard players operation #sec_reached dr_var = #gen_reached dr_var
scoreboard players operation #gen_route dr_var = #crit_route dr_var
scoreboard players operation #gen_wet dr_var = #crit_wet dr_var
scoreboard players operation #gen_cost dr_var = #crit_cost dr_var
scoreboard players operation #gen_carved dr_var = #crit_carved dr_var
scoreboard players operation #gen_pinch dr_var = #crit_pinch dr_var
scoreboard players operation #gen_opened dr_var = #crit_opened dr_var
scoreboard players set #gen_reached dr_var 1
