
# Starts this tile growing as the region that held the tile west of it

# A carried region keeps what it was drawn as rather than rolling afresh, so it
#  grows straight into its kind instead of into a block of its own waiting to be
#  painted over
# That is also what lets the river read the seam: the tile the region came from
#  is the same block, so the two do not answer as a boundary
scoreboard players operation #gen_id dr_var = #seam_kind dr_var
scoreboard players add #gen_id dr_var 26

scoreboard players add #seam_rows dr_var 1

# The wave the tile was taken on in the section before says how far back the
#  region's seed was, and keeping that shape along the column is what curves the
#  boundary: a column that sets off all at once leaves as a flat wall
# The lead is what stops a region turning up too late to hold anything, since
#  this section's own seeds start from nothing
scoreboard players operation #seam_wake dr_var = #seam_wave dr_var
scoreboard players operation #seam_wake dr_var -= #gen_seam_lead dr_var

execute if score #seam_wake dr_var matches ..0 run return run function derailed:dev/gen/_seam_now
scoreboard players add #seam_late dr_var 1
function derailed:dev/gen/_seam_later
