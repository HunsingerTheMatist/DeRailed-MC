
# Sets up the font-based HUD test's objectives and constants, so players can
#  give their settings before it starts

scoreboard objectives add dr_hud_col dummy "DeRailed HUD Test Colour"
scoreboard objectives add dr_hud_scale dummy "DeRailed HUD Test Scale"
scoreboard objectives add dr_hud_monitor dummy "DeRailed HUD Test Monitor Width"
scoreboard objectives add dr_hud_gui dummy "DeRailed HUD Test GUI Scale"

# The border's GUI pixels in from the screen's left edge, as it is from the
#  bottom; a turn is sixteen steps of 22.5 degrees
scoreboard players set $HudMargin dr_const 4
scoreboard players set $HudTurnStep dr_const 22500
scoreboard players set $Sixteen dr_const 16
scoreboard players set $Six dr_const 6
