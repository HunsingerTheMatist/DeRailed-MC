
# Puts one chest on the first column that fits, from the band two blocks either
#  way of '#ch_h' outward; fails where none does

scoreboard players set #ch_w dr_temp 2
return run function derailed:dev/big/_chest_one_band
