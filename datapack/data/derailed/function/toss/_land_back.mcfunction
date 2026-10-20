# Goes back from here along the way this thrown pile was thrown, a quarter of a
#  block at a time measured along its longer way across, until it is clear of
#  what '#toss_back' says it should not stay in, as far as 20 blocks, and puts
#  its items down there; thrown straight up, it puts them down here
# Run as the thrown display, at it

scoreboard players operation #bx dr_temp = @s dr_toss_vx
scoreboard players operation #bz dr_temp = @s dr_toss_vz
scoreboard players operation #toss_m dr_temp = #bx dr_temp
execute if score #toss_m dr_temp matches ..-1 run scoreboard players operation #toss_m dr_temp *= $MinusOne dr_const
scoreboard players operation #t dr_temp = #bz dr_temp
execute if score #t dr_temp matches ..-1 run scoreboard players operation #t dr_temp *= $MinusOne dr_const
scoreboard players operation #toss_m dr_temp > #t dr_temp
execute if score #toss_m dr_temp matches 0 run return run function derailed:toss/_land_here

# Each step, in ten-thousandths of a block, against the way across it was
#  thrown, a quarter block along whichever way is longer
scoreboard players operation #bx dr_temp *= $MinusQuarter dr_const
scoreboard players operation #bx dr_temp /= #toss_m dr_temp
scoreboard players operation #bz dr_temp *= $MinusQuarter dr_const
scoreboard players operation #bz dr_temp /= #toss_m dr_temp
execute store result storage derailed:toss step.x double 0.0001 run scoreboard players get #bx dr_temp
execute store result storage derailed:toss step.z double 0.0001 run scoreboard players get #bz dr_temp
scoreboard players set #toss_steps dr_temp 0
scoreboard players set #toss_rise dr_temp 0
function derailed:toss/_land_back_step with storage derailed:toss step
