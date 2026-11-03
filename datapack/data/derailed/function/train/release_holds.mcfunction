# Lets go of this player's holds on the train's resources once they are more
#  than 3 blocks past the side of the wagon holding them, 4.25 from its middle
# Run as the player, at the player

execute unless entity @e[type=item_display,tag=dr_train_supply,distance=..4.25] run tag @s remove dr_hold_wood
execute unless entity @e[type=item_display,tag=dr_train_supply,distance=..4.25] run tag @s remove dr_hold_iron
execute unless entity @e[type=item_display,tag=dr_train_crafting,distance=..4.25] run tag @s remove dr_hold_rail
