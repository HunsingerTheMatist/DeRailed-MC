# Keeps how dark it is now, '#night', and tells every light
# Run in the game's dimension

scoreboard players operation #night dr_var = #night dr_temp
scoreboard players operation #glow dr_var = #night dr_var
scoreboard players operation #glow dr_var *= $GlowNight dr_const
execute as @e[type=item_display,tag=dr_light,distance=0..] run function derailed:light/_glow
