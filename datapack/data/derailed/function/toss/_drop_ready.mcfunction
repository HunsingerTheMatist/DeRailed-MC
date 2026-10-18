# Readies this new thrown display as 'toss/_ready' does, still, with no thrower
#  to pass over, waiting '#drop_wait' ticks before it falls
# Run as the new display

scoreboard players set @s bs.vel.x 0
scoreboard players set @s bs.vel.y 0
scoreboard players set @s bs.vel.z 0
scoreboard players set @s dr_toss_vx 0
scoreboard players set @s dr_toss_vz 0
scoreboard players operation @s dr_toss_wait = #drop_wait dr_temp
tag @s add dr_toss_clear
function derailed:toss/_ready
