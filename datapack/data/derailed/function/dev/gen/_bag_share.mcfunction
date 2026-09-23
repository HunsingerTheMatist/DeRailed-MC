
# Works out what a draw takes off the kind drawn: a set part of one seed's share
#  of the bag, the share being the whole bag over the '#bag_n' seeds it serves

scoreboard players operation #bag_share dr_var = $TenThousand dr_const
scoreboard players operation #bag_share dr_var /= #bag_n dr_var
scoreboard players operation #bag_share dr_var *= #gen_bag_take dr_var
scoreboard players operation #bag_share dr_var /= $Hundred dr_const
