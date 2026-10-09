
# Flips the 'mined' flag in the custom data of the item in this player's main
#  hand, so it is not the item it was, and zeroes their 'dr_tool_used' so
#  another block broken in the same tick does not flip it back
# Run as the player

scoreboard players set @s dr_tool_used 0
execute if items entity @s weapon.mainhand *[custom_data~{mined:1b}] run return run item modify entity @s weapon.mainhand {type:"minecraft:set_custom_data",tag:{mined:0b}}
item modify entity @s weapon.mainhand {type:"minecraft:set_custom_data",tag:{mined:1b}}
