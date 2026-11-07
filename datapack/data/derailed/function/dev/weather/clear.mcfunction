# Stops any rain at once and starts a clear turn of weather, with clear rolled
#  for the one after

weather clear
scoreboard players set #weather_t dr_var 0
scoreboard players set #rain_now dr_var 0
scoreboard players set #rain_next dr_var 0
scoreboard players set #rain dr_var 0
