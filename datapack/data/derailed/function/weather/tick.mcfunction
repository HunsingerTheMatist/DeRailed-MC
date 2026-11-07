# Runs the weather: each turn of it lasts '$WeatherTicks', and each is rolled a
#  turn ahead, so a rain knows whether the one after rains too. While it
#  rains, every piece of a train and every empty bucket on the ground is hit
#  a chance a tick, '$RainHitChance' in 10000 at full strength, less while the
#  rain grows or dies away
# The weather keeps still, as it is, while '#weather_on' is not 1
# Run in the game's dimension

execute unless score #weather_on dr_var matches 1 run return 0

scoreboard players add #weather_t dr_var 1
execute if score #weather_t dr_var >= $WeatherTicks dr_config run function derailed:weather/_turn

# Rain grows a hundredth of its strength a tick from the start of its turn, and
#  dies away a hundredth a tick over the last '$RainFade' of it where the next
#  turn is not rain, as the game's own rain does, so the two keep together;
#  one following another keeps its strength
scoreboard players operation #fade dr_temp = $WeatherTicks dr_config
scoreboard players operation #fade dr_temp -= $RainFade dr_const
scoreboard players operation #grow dr_temp = #rain_now dr_var
execute if score #rain_next dr_var matches 0 if score #weather_t dr_var >= #fade dr_temp run scoreboard players set #grow dr_temp 0
execute if score #rain_now dr_var matches 1 if score #rain_next dr_var matches 0 if score #weather_t dr_var = #fade dr_temp run weather clear
execute if score #grow dr_temp matches 1 if score #rain dr_var matches ..99 run scoreboard players add #rain dr_var 1
execute if score #grow dr_temp matches 0 if score #rain dr_var matches 1.. run scoreboard players remove #rain dr_var 1
execute unless score #rain dr_var matches 1.. run return 0

scoreboard players operation #rain_p dr_var = #rain dr_var
scoreboard players operation #rain_p dr_var *= $RainHitChance dr_config
scoreboard players operation #rain_p dr_var /= $Hundred dr_const
execute as @e[type=item_display,tag=dr_train_piece,distance=0..] if function derailed:weather/_roll run function derailed:weather/_hit
execute as @e[type=interaction,tag=dr_placement,distance=0..] if score @s dr_item = $Bucket dr_const if function derailed:weather/_roll at @s run function derailed:weather/_fill
