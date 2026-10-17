# Sets this new thrown display going: the look of what it carries, its box the
#  size of the pile they make, centred on the eyes it was thrown from, the way
#  it faces, its velocity along the aim '#ax' '#ay' '#az', and what it carries,
#  who threw it and how long it has flown
# Run as the new display, at the thrower's eyes

function derailed:toss/_look

function derailed:toss/_box_height
execute on passengers store result entity @s height float 0.0001 run scoreboard players get #toss_h dr_temp

# It faces the way the placement it makes will, snapped to 90 degree steps as
#  'item/place_new' snaps it
scoreboard players operation #rotation dr_temp = #curr_rotation dr_arg
scoreboard players add #rotation dr_temp 405
scoreboard players operation #rotation dr_temp /= $RotationStep dr_const
scoreboard players operation #rotation dr_temp *= $RotationStep dr_const
execute store result entity @s Rotation[0] float 1 run scoreboard players remove #rotation dr_temp 360

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

scoreboard players operation @s dr_item = #curr_item dr_arg
scoreboard players operation @s dr_count = #curr_item_count dr_arg
scoreboard players operation @s dr_player_id = #curr_player_id dr_arg
scoreboard players set @s dr_toss_age 0
tag @s remove dr_toss_new

# The box's bottom is half its height under the eyes
scoreboard players operation #toss_h dr_temp /= $Two dr_const
scoreboard players operation #ay0 dr_temp -= #toss_h dr_temp
execute store result entity @s Pos[1] double 0.0001 run scoreboard players get #ay0 dr_temp
