# Sets this new thrown display going: as 'toss/_ready' readies it, its box
#  centred on the eyes it was thrown from and its velocity along the aim '#ax'
#  '#ay' '#az'
# Run as the new display, at the thrower's eyes

function derailed:toss/_ready

# Its velocity, in ten-thousandths of a block a tick, the aim's step scaled to
#  the speed for how many it holds: '$TossSpeed1', '$TossSpeed2', or
#  '$TossSpeed3' for three or more
scoreboard players operation #toss_speed dr_temp = $TossSpeed1 dr_config
execute if score #curr_item_count dr_arg matches 2 run scoreboard players operation #toss_speed dr_temp = $TossSpeed2 dr_config
execute if score #curr_item_count dr_arg matches 3.. run scoreboard players operation #toss_speed dr_temp = $TossSpeed3 dr_config
scoreboard players operation #ax dr_temp *= #toss_speed dr_temp
scoreboard players operation @s bs.vel.x = #ax dr_temp
scoreboard players operation @s bs.vel.x /= $TenThousand dr_const
scoreboard players operation #ay dr_temp *= #toss_speed dr_temp
scoreboard players operation @s bs.vel.y = #ay dr_temp
scoreboard players operation @s bs.vel.y /= $TenThousand dr_const
scoreboard players operation #az dr_temp *= #toss_speed dr_temp
scoreboard players operation @s bs.vel.z = #az dr_temp
scoreboard players operation @s bs.vel.z /= $TenThousand dr_const

# The velocity across it sets off with, kept for finding its way back from what
#  it lands on, since hitting things takes it out of 'bs.vel'
scoreboard players operation @s dr_toss_vx = @s bs.vel.x
scoreboard players operation @s dr_toss_vz = @s bs.vel.z

# The box's bottom is half its height under the eyes
scoreboard players operation #toss_h dr_temp /= $Two dr_const
scoreboard players operation #ay0 dr_temp -= #toss_h dr_temp
execute store result entity @s Pos[1] double 0.0001 run scoreboard players get #ay0 dr_temp
