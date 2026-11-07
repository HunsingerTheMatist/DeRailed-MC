# Begins the weather rolled for the turn starting now, starting the game's rain
#  where it begins to rain, and rolls the next: rain '$RainOdds' times in 10000

scoreboard players set #weather_t dr_var 0
scoreboard players operation #rain_was dr_temp = #rain_now dr_var
scoreboard players operation #rain_now dr_var = #rain_next dr_var
scoreboard players set #rain_next dr_var 0
execute store result score #r dr_temp run random value 0..9999
execute if score #r dr_temp < $RainOdds dr_config run scoreboard players set #rain_next dr_var 1
execute if score #rain_now dr_var matches 1 if score #rain_was dr_temp matches 0 run weather rain
