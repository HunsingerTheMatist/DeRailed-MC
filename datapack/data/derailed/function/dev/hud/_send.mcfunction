
# Sends this player the HUD test as their action bar, in the font for their
#  scale and GUI scale: their lead to near the screen's left edge, the paper
#  border, then the picture and its arrows from the map's left edge
# Their GUI scale, 'dr_hud_gui', is 2 unless set, and their monitor's width in
#  pixels, 'dr_hud_monitor', 1920; their scale goes by their GUI scale, 3 at 1,
#  2 at 2 and 1 above, and 'dr_hud_scale' set to 1, 2 or 3 overrides it
# Run as the player

execute unless score @s dr_hud_monitor matches -2147483648.. run scoreboard players set @s dr_hud_monitor 1920
execute unless score @s dr_hud_gui matches 1.. run scoreboard players set @s dr_hud_gui 2

scoreboard players set #hs dr_temp 2
execute if score @s dr_hud_gui matches 1 run scoreboard players set #hs dr_temp 3
execute if score @s dr_hud_gui matches 3.. run scoreboard players set #hs dr_temp 1
execute if score @s dr_hud_scale matches 1..3 run scoreboard players operation #hs dr_temp = @s dr_hud_scale

# The font for that scale at their GUI scale, those past the table's taking its
#  last
scoreboard players operation #hg dr_temp = @s dr_hud_gui
execute if score #hg dr_temp > $HudGuiScales dr_const run scoreboard players operation #hg dr_temp = $HudGuiScales dr_const
scoreboard players remove #hs dr_temp 1
scoreboard players operation #hs dr_temp *= $HudGuiScales dr_const
scoreboard players operation #hs dr_temp += #hg dr_temp
execute store result storage derailed:hud f.i int 1 run scoreboard players remove #hs dr_temp 1

data modify storage derailed:hud frame set value {text:"",shadow_color:0,extra:[]}
function derailed:dev/hud/_send_font with storage derailed:hud f
function derailed:dev/hud/lead
data modify storage derailed:hud frame.extra append value {text:""}
data modify storage derailed:hud frame.extra[-1].text set from storage derailed:hud strips.open
data modify storage derailed:hud frame.extra append from storage derailed:hud content
data modify storage derailed:hud frame.extra append value {text:""}
data modify storage derailed:hud frame.extra[-1].text set from storage derailed:hud strips.close
title @s actionbar {nbt:"frame",storage:"derailed:hud",interpret:true}
