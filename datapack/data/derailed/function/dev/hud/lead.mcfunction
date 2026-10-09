
# Adds this player's lead to their HUD test frame, the spaces back from the
#  middle of the screen to '$HudMargin' in from its left edge: the screen's
#  width in GUI pixels is 'dr_hud_monitor', its width in pixels, over
#  'dr_hud_gui', the GUI scale; the action bar is centred on half of it, and
#  all of its text's width is the lead, made of a space back for each power of
#  two in it
# Run as the player

scoreboard players operation #hud_l dr_temp = @s dr_hud_monitor
scoreboard players operation #hud_l dr_temp /= @s dr_hud_gui
scoreboard players operation #hud_l dr_temp /= $Two dr_const
scoreboard players operation #hud_l dr_temp -= $HudMargin dr_const
scoreboard players operation #hud_l dr_temp *= $Two dr_const

execute if score #hud_l dr_temp matches 2048.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 2048.. run scoreboard players remove #hud_l dr_temp 2048
execute if score #hud_l dr_temp matches 1024.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 1024.. run scoreboard players remove #hud_l dr_temp 1024
execute if score #hud_l dr_temp matches 512.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 512.. run scoreboard players remove #hud_l dr_temp 512
execute if score #hud_l dr_temp matches 256.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 256.. run scoreboard players remove #hud_l dr_temp 256
execute if score #hud_l dr_temp matches 128.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 128.. run scoreboard players remove #hud_l dr_temp 128
execute if score #hud_l dr_temp matches 64.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 64.. run scoreboard players remove #hud_l dr_temp 64
execute if score #hud_l dr_temp matches 32.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 32.. run scoreboard players remove #hud_l dr_temp 32
execute if score #hud_l dr_temp matches 16.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 16.. run scoreboard players remove #hud_l dr_temp 16
execute if score #hud_l dr_temp matches 8.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 8.. run scoreboard players remove #hud_l dr_temp 8
execute if score #hud_l dr_temp matches 4.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 4.. run scoreboard players remove #hud_l dr_temp 4
execute if score #hud_l dr_temp matches 2.. run data modify storage derailed:hud frame.extra append value {text:""}
execute if score #hud_l dr_temp matches 2.. run scoreboard players remove #hud_l dr_temp 2
