
# Clears the barriers over the rail block this marker is on, then moves it a
#  tenth of a block along the path and does the same, until it reaches the
#  front end of the train or '#left' runs out
# Run as the walking marker

execute at @s positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ air replace pink_stained_glass_pane strict
execute at @s if entity @e[type=marker,tag=dr_reach_front,distance=..0.15] run return 0
execute if score #left dr_temp matches ..0 run return 0
scoreboard players remove #left dr_temp 100
scoreboard players add @s dr_ad 100
execute if score @s dr_ad >= @s dr_alen run function derailed:train/_axle_next
function derailed:train/_axle_pos
function derailed:train/_reach_unwalk
