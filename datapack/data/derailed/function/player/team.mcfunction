# Takes the vanilla team this player is on into 'dr_team': 1 for red, 2 for
#  blue and 0 for none
# Run as the player

scoreboard players set @s dr_team 0
execute if entity @s[team=dr_red] run scoreboard players set @s dr_team 1
execute if entity @s[team=dr_blue] run scoreboard players set @s dr_team 2
