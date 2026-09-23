
# Turns the bled tiles in '#bag_take' into what they are worth of the bag and
#  takes that off the kind in '#gen_kind'
# A share of the bag for every tile is the whole bag over the section's tiles,
#  since the bag is one seed's share for every seed and a region is the
#  section's tiles over the seeds; the multiplying goes first so that nothing is
#  lost to rounding on the way

scoreboard players operation #bag_take dr_var *= $TenThousand dr_const
scoreboard players operation #bag_take dr_var /= $SectionTiles dr_const
function derailed:dev/gen/_bag_shift
