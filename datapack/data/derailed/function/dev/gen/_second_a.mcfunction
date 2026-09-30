
# Sets the second route's search up: the first route's figures kept, and the
#  band and zone drawn round it; returns 0 where the first route never got
#  across, and leaves '#sec_pinched' at 1 where it pinches anywhere, which is
#  what the second route has to get round
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
#  two things drawn round it: a band, white on the tiles beside it, where rock
#  is never cut for the second route, since it is what pinches the first, and
#  a zone, black out to four steps along the grid from each pinched cell but
#  the cell at either end of a run three or more long, where rock is never cut
#  for it either, light gray where the two fall on the same tile
fill ~ ~3 ~ ~31 ~3 ~15 air strict
clone ~ ~2 ~ ~31 ~2 ~15 ~ ~3 ~ strict filtered red_stained_glass
execute as @e[type=marker,tag=dr_pinch,distance=0..] at @s run setblock ~ ~3 ~ gray_stained_glass strict
data modify storage derailed:gen e.f set value "_second_band_at"
function derailed:dev/gen/_each
execute as @e[type=marker,tag=dr_pinch,distance=0..] run function derailed:dev/gen/_pinch_end
execute as @e[type=marker,tag=dr_pinch,tag=!dr_pinch_end,distance=0..] at @s run function derailed:dev/gen/_second_zone_at

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

# A first route that pinches nowhere has nothing to be got round, and the
#  second route is the first
scoreboard players set #sec_detour_max dr_var 0
scoreboard players set #gen_astray dr_var 0
scoreboard players set #gen_carved dr_var 0
scoreboard players set #gen_opened dr_var 0
execute store success score #sec_pinched dr_var if entity @e[type=marker,tag=dr_pinch,distance=0..]
return 1
