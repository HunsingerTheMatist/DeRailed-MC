# Follows this player's aim out from their eyes, as 'track/_ghost_step' does,
#  for the tiles their team's track could go on next, the end of which is
#  tagged 'dr_end_on' meanwhile
# Run as the player, at their eyes, facing where they aim

scoreboard players operation #team dr_temp = @s dr_team
tag @e[type=marker,tag=dr_end_on,distance=0..] remove dr_end_on
execute as @e[type=marker,tag=dr_track_end,distance=0..] if score @s dr_team = #team dr_temp run tag @s add dr_end_on
execute unless entity @e[type=marker,tag=dr_end_on,distance=0..] run return 0

tag @s add dr_ray_self
scoreboard players set #ray_steps dr_temp 0
function derailed:track/_ghost_step
tag @s remove dr_ray_self
