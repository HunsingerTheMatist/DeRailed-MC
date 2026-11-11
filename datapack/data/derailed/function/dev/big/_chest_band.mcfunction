
# Tags 'dr_big_cand' every column within '#ch_w' blocks of '#ch_h' high that a
#  chest fits on, and where none does, tries again a block wider either way
#  with a rock slab beside it doing as well as bedrock, until the band takes in
#  every height a column can have

scoreboard players operation #ch_lo dr_temp = #ch_h dr_temp
scoreboard players operation #ch_lo dr_temp -= #ch_w dr_temp
scoreboard players operation #ch_hi dr_temp = #ch_h dr_temp
scoreboard players operation #ch_hi dr_temp += #ch_w dr_temp
execute as @e[type=marker,tag=dr_big_col,distance=0..] if score @s dr_bh >= #ch_lo dr_temp if score @s dr_bh <= #ch_hi dr_temp at @s run function derailed:dev/big/_chest_fits
execute if entity @e[type=marker,tag=dr_big_cand,distance=0..] run return 1
execute if score #ch_w dr_temp matches 15.. run return 0
scoreboard players add #ch_w dr_temp 1
scoreboard players set #ch_slab dr_temp 1
function derailed:dev/big/_chest_band
