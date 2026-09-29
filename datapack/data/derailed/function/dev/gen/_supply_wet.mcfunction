
# Counts the water under each route on the terrain as it now stands, into
#  '#crit_wet' for the first and '#sec_wet' for the second, on the layer below
#  the terrain: the water is copied down, whatever lies under no tile of the
#  route is wiped, and a fill that takes the rest away says how many it took
# Positioned at the section's corner, on the visible layer, with the routes
#  kept three above

fill ~ ~-1 ~ ~31 ~-1 ~15 air strict
clone ~ ~ ~ ~31 ~ ~15 ~ ~-1 ~ strict filtered #derailed:cost_water
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~-1 ~ strict filtered air
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~-1 ~ strict filtered magenta_stained_glass
scoreboard players set #crit_wet dr_var 0
execute store result score #crit_wet dr_var run fill ~ ~-1 ~ ~31 ~-1 ~15 air replace #derailed:cost_water strict
fill ~ ~-1 ~ ~31 ~-1 ~15 air strict

clone ~ ~ ~ ~31 ~ ~15 ~ ~-1 ~ strict filtered #derailed:cost_water
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~-1 ~ strict filtered air
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~-1 ~ strict filtered red_stained_glass
scoreboard players set #sec_wet dr_var 0
execute store result score #sec_wet dr_var run fill ~ ~-1 ~ ~31 ~-1 ~15 air replace #derailed:cost_water strict
fill ~ ~-1 ~ ~31 ~-1 ~15 air strict
