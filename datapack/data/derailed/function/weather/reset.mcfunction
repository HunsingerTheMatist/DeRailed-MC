# Puts the weather back to how a run starts: clear at once, the turn starting
#  now clear and '$WeatherClearStart' long, and the turn after it rolled as any
#  is, rain '$RainOdds' times in 10000

weather clear
scoreboard players set #rain_now dr_var 0
scoreboard players set #rain dr_var 0
scoreboard players operation #weather_t dr_var = $WeatherTicks dr_config
scoreboard players operation #weather_t dr_var -= $WeatherClearStart dr_config
scoreboard players set #rain_next dr_var 0
execute store result score #r dr_temp run random value 0..9999
execute if score #r dr_temp < $RainOdds dr_config run scoreboard players set #rain_next dr_var 1
