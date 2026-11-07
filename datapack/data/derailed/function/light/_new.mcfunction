# Gives the light just summoned its slot and reach, '#light', and tells it how
#  dark it is
# Run in the game's dimension

scoreboard players operation @e[type=item_display,tag=dr_light_new,distance=0..] dr_light = #light dr_temp
execute as @e[type=item_display,tag=dr_light_new,distance=0..] run function derailed:light/_glow
tag @e[type=item_display,tag=dr_light_new,distance=0..] remove dr_light_new
