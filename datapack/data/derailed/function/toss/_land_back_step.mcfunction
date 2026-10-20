# Puts the thrown pile's items down here once it is clear of what '#toss_back'
#  says it should not stay in, 1 what it rested on, tagged 'dr_toss_under', and
#  2 water, out of which it comes up onto the bank first, or after 80 steps, 20
#  blocks, and otherwise takes another step of $(x) $(z) back
# Run as the thrown display, at a point on its way back

execute if score #toss_back dr_temp matches 1 positioned ~-0.5 ~-1 ~-0.5 unless entity @e[tag=dr_toss_under,dx=0,dy=0,dz=0] run return run function derailed:toss/_land_here
execute if score #toss_back dr_temp matches 2 unless block ~ ~ ~ #derailed:water_like unless block ~ ~-1 ~ #derailed:water_like run return run function derailed:toss/_land_surface
scoreboard players add #toss_steps dr_temp 1
execute if score #toss_steps dr_temp matches 80.. run return run function derailed:toss/_land_here
$execute positioned ~$(x) ~ ~$(z) run function derailed:toss/_land_back_step with storage derailed:toss step
