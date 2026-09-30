
# Ends the supply's repair and judges the tail and the windows
# Positioned at the section's corner, while the supply check's flood is still
#  laid

# What is left short once the search is done
function derailed:dev/gen/_rep_measure
scoreboard players operation #gen_repair_left dr_var = #rep_score dr_var
function derailed:dev/gen/_rep_totals

# Then the tail and the windows are judged, for the report and for a section
#  left wanting to be rerolled
function derailed:dev/gen/_spread_tail
function derailed:dev/gen/_spread
