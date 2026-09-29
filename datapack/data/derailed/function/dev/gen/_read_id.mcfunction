# Reads the region back out of the block on this tile, a bit at a time, each
#  of the tags 'region_id/bit_1' to 'region_id/bit_16' holding the blocks whose
#  id has that bit, in the order of the palette in 'load'
# A block that is no region's leaves '#gen_id' as it was
# Ids 26 to 30 are the regions carried over the western seam, which keep the kind
#  they had in the section before

execute unless block ~ ~ ~ #derailed:region_id/any run return 0
scoreboard players set #gen_id dr_var 0
execute if block ~ ~ ~ #derailed:region_id/bit_1 run scoreboard players add #gen_id dr_var 1
execute if block ~ ~ ~ #derailed:region_id/bit_2 run scoreboard players add #gen_id dr_var 2
execute if block ~ ~ ~ #derailed:region_id/bit_4 run scoreboard players add #gen_id dr_var 4
execute if block ~ ~ ~ #derailed:region_id/bit_8 run scoreboard players add #gen_id dr_var 8
execute if block ~ ~ ~ #derailed:region_id/bit_16 run scoreboard players add #gen_id dr_var 16
