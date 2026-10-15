# Follows this player's aim out from their eyes, as 'track/_ghost_step' does
# Run as the player, at their eyes, facing where they aim

tag @s add dr_ray_self
scoreboard players set #ray_steps dr_temp 0
function derailed:track/_ghost_step
tag @s remove dr_ray_self
