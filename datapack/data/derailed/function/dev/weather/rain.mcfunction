# Ends the turn of weather now, with rain rolled for the one starting, which
#  begins next tick if the weather is going ('dev/weather/start')

scoreboard players set #rain_next dr_var 1
scoreboard players operation #weather_t dr_var = $WeatherTicks dr_config
scoreboard players remove #weather_t dr_var 1
