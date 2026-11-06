# Heats this piece a tick for each piece beside it in its train that is
#  burning, and sets it on fire once it has taken '$HeatTicks' of heat, or for
#  the engine '$EngineHeatTicks'; what it has taken stays when the fires beside
#  it are put out, and goes only once it has caught and been put out itself
# Run as the piece's item display

scoreboard players operation #team dr_temp = @s dr_team
scoreboard players operation #before dr_temp = @s dr_slot
scoreboard players remove #before dr_temp 1
scoreboard players operation #after dr_temp = @s dr_slot
scoreboard players add #after dr_temp 1
scoreboard players set #near dr_temp 0
execute as @e[type=item_display,tag=dr_train_piece,tag=dr_burning,distance=0..] if score @s dr_team = #team dr_temp if score @s dr_slot = #before dr_temp run scoreboard players add #near dr_temp 1
execute as @e[type=item_display,tag=dr_train_piece,tag=dr_burning,distance=0..] if score @s dr_team = #team dr_temp if score @s dr_slot = #after dr_temp run scoreboard players add #near dr_temp 1
execute if score #near dr_temp matches 0 run return 0

scoreboard players operation @s dr_heat += #near dr_temp
scoreboard players operation #cap dr_temp = $HeatTicks dr_config
execute if entity @s[tag=dr_train_engine] run scoreboard players operation #cap dr_temp = $EngineHeatTicks dr_config
execute if score @s dr_heat >= #cap dr_temp run function derailed:train/ignite
