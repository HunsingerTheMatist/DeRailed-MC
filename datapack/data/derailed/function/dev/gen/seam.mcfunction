
# Carries the regions on the far side of the western boundary into this section,
#  so a blob keeps both its kind and its shape across the seam
# Positioned at the section's corner

scoreboard players set #seam_rows dr_var 0
scoreboard players set #seam_seen dr_var 0
scoreboard players set #seam_ok dr_var 0
scoreboard players set #seam_late dr_var 0
scoreboard players set #seam_lost dr_var 0

# Every marker here sits on a block corner rather than a tile centre, since they
#  are all summoned with '~ ~ ~' from a corner the section was positioned at, so
#  a note is found at no distance at all and its neighbours at a whole block
scoreboard players set #seam_min dr_var 2147483647
scoreboard players set #gen_row dr_var 16
function derailed:dev/gen/_seam_scan

# Nothing to the west means this is the first section, and the edge starts bare
execute if score #seam_min dr_var matches 2147483647 run return 0

scoreboard players set #gen_row dr_var 16
function derailed:dev/gen/_seam_row
