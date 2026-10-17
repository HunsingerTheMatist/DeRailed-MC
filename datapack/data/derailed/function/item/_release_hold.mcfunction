# Lets go of this placement's hold once the player it is held for is more than
#  3 blocks away
# Run as the placement's interaction entity, at it

scoreboard players operation #holder dr_temp = @s dr_player_id
execute as @a[distance=..3] if score @s dr_player_id = #holder dr_temp run return 0
tag @s remove dr_held
scoreboard players reset @s dr_player_id
