
# Picks the rows of the first section's first column the void grows in from,
#  '#void_a', '#void_b' and '#void_c', anywhere in it but the middle three of
#  the start station's rows, at least 4 rows apart and not all on one side of
#  the station, and how many tiles west of the column each starts, 0 to 2, in
#  '#void_ka', '#void_kb' and '#void_kc', then marks where each starts with a
#  marker tagged 'dr_void_mid' for seeds to keep their spacing from
# Positioned at the section's corner, which stands at z 0

function derailed:dev/gen/_void_pick_a
function derailed:dev/gen/_void_pick_b
function derailed:dev/gen/_void_pick_c
execute store result score #void_ka dr_var run random value 0..2 derailed:gen
execute store result score #void_kb dr_var run random value 0..2 derailed:gen
execute store result score #void_kc dr_var run random value 0..2 derailed:gen
function derailed:dev/gen/_void_mids
