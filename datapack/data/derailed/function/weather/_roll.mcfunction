# Succeeds '#rain_p' times in 10000

execute store result score #r dr_temp run random value 0..9999
return run execute if score #r dr_temp < #rain_p dr_var
