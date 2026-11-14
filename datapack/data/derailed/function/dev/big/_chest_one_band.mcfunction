
# Tries the columns within '#ch_w' blocks of '#ch_h' high for one chest, then a
#  block wider either way, until the band takes in every height a column can
#  have

function derailed:dev/big/_chest_pool
execute if function derailed:dev/big/_chest_one_draw run return 1
execute if score #ch_w dr_temp matches 15.. run return 0
scoreboard players add #ch_w dr_temp 1
return run function derailed:dev/big/_chest_one_band
