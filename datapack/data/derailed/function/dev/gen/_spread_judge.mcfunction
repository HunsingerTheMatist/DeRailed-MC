
# Counts the window just filled, and again where either kind is wanting, then
#  takes the next column
# Positioned at the section's corner

# A section loosened after many fresh starts leaves out the windows that are
#  more the section before's columns than its own, ending on its fourteenth
#  column or sooner
execute if score #gen_lenient dr_var matches 1 if score #sp_col dr_var matches ..13 run return run function derailed:dev/gen/_spread_step
scoreboard players add #sp_judged dr_var 1
execute if score #sp_iron dr_var < #sp_need dr_var run function derailed:dev/gen/_spread_gap
execute if score #sp_iron dr_var >= #sp_need dr_var if score #sp_wood dr_var < #sp_need dr_var run function derailed:dev/gen/_spread_gap
function derailed:dev/gen/_spread_step
