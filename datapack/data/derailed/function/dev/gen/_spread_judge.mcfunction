
# Counts the window just filled where either kind is wanting, then takes the
#  next column
# Positioned at the section's corner

execute if score #sp_iron dr_var < #sp_need dr_var run scoreboard players add #gen_spread_gaps dr_var 1
execute if score #sp_iron dr_var >= #sp_need dr_var if score #sp_wood dr_var < #sp_need dr_var run scoreboard players add #gen_spread_gaps dr_var 1
function derailed:dev/gen/_spread_step
