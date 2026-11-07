# Sets this light's glow colour, which the night post effect reads it by: how
#  dark it is in its red, from '#glow', and its slot and how far it reaches in
#  its green and blue, from 'dr_light'
# Run as the light

scoreboard players operation #glow dr_temp = #glow dr_var
scoreboard players operation #glow dr_temp += @s dr_light
execute store result entity @s glow_color_override int 1 run scoreboard players get #glow dr_temp
