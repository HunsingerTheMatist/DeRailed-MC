# Puts the thrown pile's items down here once it is clear of what '#toss_back'
#  says it should not stay in, 1 what it rested on, tagged 'dr_toss_under', and
#  2 water, or after 20 steps, and otherwise takes another step of $(x) $(z)
#  back
# Run as the thrown display, at a point on its way back

execute if score #toss_back dr_temp matches 1 positioned ~-0.5 ~-1 ~-0.5 unless entity @e[tag=dr_toss_under,dx=0,dy=0,dz=0] run return run function derailed:toss/_land_here
execute if score #toss_back dr_temp matches 2 unless block ~ ~ ~ water unless block ~ ~-1 ~ water run return run function derailed:toss/_land_here
scoreboard players add #toss_steps dr_temp 1
execute if score #toss_steps dr_temp matches 20.. run return run function derailed:toss/_land_here
$execute positioned ~$(x) ~ ~$(z) run function derailed:toss/_land_back_step with storage derailed:toss step
