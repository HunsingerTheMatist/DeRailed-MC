# Puts the thrown pile's items down from the first block up from here a pile
#  could stand in, as far as 3 up, since the walk back out of the water runs at
#  the water's height and stops inside the bank it comes to, under where a pile
#  would stand on it
# Run as the thrown display, at the point its walk back stopped

execute if block ~ ~ ~ #derailed:valid_placements run return run function derailed:toss/_land_here
scoreboard players add #toss_rise dr_temp 1
execute if score #toss_rise dr_temp matches 4.. run return run function derailed:toss/_land_here
execute positioned ~ ~1 ~ run function derailed:toss/_land_surface
