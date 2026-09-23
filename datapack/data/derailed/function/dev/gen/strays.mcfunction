
# Hands every stray tile to a region beside it: a tile that meets no other of
#  its own region along an edge, now that the rivers have been cut round it
# A stray shares its region with nothing beside it, so handing it on can strand
#  nothing else, and one pass over the section is enough
# Positioned at the section's corner, once the rivers are cut and before the
#  kinds are drawn

scoreboard players set #stray_n dr_var 0
scoreboard players set #stray_z dr_var 0
function derailed:dev/gen/_stray_row
scoreboard players operation #gen_strays dr_var += #stray_n dr_var
