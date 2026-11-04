# Moves the front end of this train on as an axle moves, and by the moves it
#  missed, 'dr_lag', as well, where there is track to make them on; otherwise
#  holds it at the end of the track and counts the move it misses
# Run as the train's front end marker

scoreboard players add @s dr_lag 0
scoreboard players operation #ahead dr_arg = @s dr_lag
execute if function derailed:train/_runs_out run return run scoreboard players operation @s dr_lag += $TrainSpeed dr_config
scoreboard players operation @s dr_ad += @s dr_lag
scoreboard players set @s dr_lag 0
function derailed:train/_axle
