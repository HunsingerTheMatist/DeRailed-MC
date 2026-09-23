
# Turns the bled tiles in '#bag_take' into what they are worth of the bag and
#  takes that off the kind in '#gen_kind'

scoreboard players operation #bag_take dr_var *= #kind_all dr_var
scoreboard players operation #bag_take dr_var *= $TenThousand dr_const
scoreboard players operation #bag_take dr_var /= $SectionTiles dr_const
scoreboard players operation #bag_take dr_var /= #kind_off dr_var
function derailed:dev/gen/_bag_shift
