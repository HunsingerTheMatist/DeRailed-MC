
# Counts the window just filled where either kind is wanting, then takes the
#  next column
# Positioned at the section's corner

execute if score #sp_iron dr_var < #sp_need dr_var run function derailed:dev/gen/_spread_gap
execute if score #sp_iron dr_var >= #sp_need dr_var if score #sp_wood dr_var < #sp_need dr_var run function derailed:dev/gen/_spread_gap
function derailed:dev/gen/_spread_step
