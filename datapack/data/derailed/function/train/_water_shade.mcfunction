
# Shades the water wagon's tank by the water it has used, 'dr_water_used', from
#  light blue full to red dry: the hundredths of the water it holds,
#  'dr_water_cap', that are used pick its tint, drawn where it has changed
# Run as the water wagon's item display

execute unless score @s dr_water_cap matches 1.. run return 0
scoreboard players operation #step dr_temp = @s dr_water_used
scoreboard players operation #step dr_temp *= $Hundred dr_const
scoreboard players operation #step dr_temp /= @s dr_water_cap
execute if score #step dr_temp = @s dr_water_step run return 0
scoreboard players operation @s dr_water_step = #step dr_temp
execute store result storage derailed:train tint.step int 1 run scoreboard players get #step dr_temp
function derailed:train/_water_tint with storage derailed:train tint
