# Moves this player's light to their eyes, or puts one there if they have
#  none, and tags it 'dr_light_kept'
# Run as the player, at them, in the game's dimension

scoreboard players operation #pid dr_temp = @s dr_player_id
scoreboard players set #found dr_temp 0
execute anchored eyes positioned ^ ^ ^ as @e[type=item_display,tag=dr_light_player,distance=0..] if score @s dr_player_id = #pid dr_temp store success score #found dr_temp run tp @s ~ ~ ~
execute as @e[type=item_display,tag=dr_light_player,distance=0..] if score @s dr_player_id = #pid dr_temp run tag @s add dr_light_kept
execute if score #found dr_temp matches 0 anchored eyes positioned ^ ^ ^ run function derailed:light/_add_player
