
# Puts two chests on the first pair of columns that fit, on different regions
#  and '#ch_rad' or more blocks apart, from the band two blocks either way of
#  '#ch_h' outward; fails where no pair does

scoreboard players set #ch_w dr_temp 2
return run function derailed:dev/big/_chest_pair_band
