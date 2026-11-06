# Refills the water wagon of this player's team from their full bucket and puts
#  it and the engine out, where either is burning or the train has used
#  '$RefillWait' of its water; refuses the bucket otherwise
# Run as the player

scoreboard players operation #team dr_temp = @s dr_team
tag @e[type=item_display,tag=dr_water_pair,distance=0..] remove dr_water_pair
execute as @e[type=item_display,tag=dr_train_engine,distance=0..] if score @s dr_team = #team dr_temp run tag @s add dr_water_pair
execute as @e[type=item_display,tag=dr_train_water,distance=0..] if score @s dr_team = #team dr_temp run tag @s add dr_water_pair

scoreboard players set #refill dr_temp 0
execute if entity @e[type=item_display,tag=dr_water_pair,tag=dr_burning,distance=0..] run scoreboard players set #refill dr_temp 1
execute if score @n[type=item_display,tag=dr_water_pair,tag=dr_train_water,distance=0..] dr_water_used >= $RefillWait dr_config run scoreboard players set #refill dr_temp 1
execute if score #refill dr_temp matches 0 run return run function derailed:item/reject

scoreboard players set @e[type=item_display,tag=dr_water_pair,tag=dr_train_water,distance=0..] dr_water_used 0
execute as @e[type=item_display,tag=dr_water_pair,tag=dr_burning,distance=0..] run function derailed:train/extinguish
function derailed:item/bucket/empty
