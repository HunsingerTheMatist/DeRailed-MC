# Lets go of this player's holds on their team's train's resources once they
#  are more than 3 blocks past the side of the wagon holding them, 4.25 from
#  its middle
# Run as the player, at the player

scoreboard players operation #team dr_temp = @s dr_team
scoreboard players set #near_supply dr_temp 0
scoreboard players set #near_crafting dr_temp 0
execute as @e[type=item_display,tag=dr_train_supply,distance=..4.25] if score @s dr_team = #team dr_temp run scoreboard players set #near_supply dr_temp 1
execute as @e[type=item_display,tag=dr_train_crafting,distance=..4.25] if score @s dr_team = #team dr_temp run scoreboard players set #near_crafting dr_temp 1
execute if score #near_supply dr_temp matches 0 run tag @s remove dr_hold_wood
execute if score #near_supply dr_temp matches 0 run tag @s remove dr_hold_iron
execute if score #near_crafting dr_temp matches 0 run tag @s remove dr_hold_rail
