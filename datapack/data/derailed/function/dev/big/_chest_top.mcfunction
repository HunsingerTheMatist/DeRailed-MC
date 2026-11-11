
# Climbs this column of rock to its top block of bedrock and marks it there with
#  a marker tagged 'dr_big_col', holding its height in 'dr_bh' and its tile's
#  depth, '#ch_d', in 'dr_bd'
# Positioned at a block of bedrock in the column

execute if block ~ ~1 ~ bedrock positioned ~ ~1 ~ run return run function derailed:dev/big/_chest_top
execute summon marker run function derailed:dev/big/_chest_col
