# Takes '$RainCool' off the heat this piece has taken, and for the water wagon
#  off the water it has used, none going below nothing; a burning piece cooled
#  below what it takes to catch goes out, the water wagon once it has water
#  again
# Run as the piece's item display

scoreboard players operation @s dr_heat -= $RainCool dr_config
execute if score @s dr_heat matches ..-1 run scoreboard players set @s dr_heat 0
execute if entity @s[tag=dr_train_water] run scoreboard players operation @s dr_water_used -= $RainCool dr_config
execute if entity @s[tag=dr_train_water] if score @s dr_water_used matches ..-1 run scoreboard players set @s dr_water_used 0

execute unless entity @s[tag=dr_burning] run return 0
execute if entity @s[tag=dr_train_water] if score @s dr_water_used < @s dr_water_cap run return run function derailed:train/extinguish
execute if entity @s[tag=dr_train_water] run return 0
scoreboard players operation #cap dr_temp = $HeatTicks dr_config
execute if entity @s[tag=dr_train_engine] run scoreboard players operation #cap dr_temp = $EngineHeatTicks dr_config
execute if score @s dr_heat < #cap dr_temp run function derailed:train/extinguish
