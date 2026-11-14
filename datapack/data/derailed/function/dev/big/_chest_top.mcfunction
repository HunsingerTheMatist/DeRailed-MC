
# Climbs this column of rock to its top block of bedrock and marks it there with
#  a marker tagged 'dr_big_col' ('_chest_col'), its tile's depth '#ch_d' and
#  region '#ch_g'
# Positioned at a block of bedrock in the column

execute if block ~ ~1 ~ bedrock positioned ~ ~1 ~ run return run function derailed:dev/big/_chest_top
execute summon marker run function derailed:dev/big/_chest_col
