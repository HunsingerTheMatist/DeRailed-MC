
# Measures each of this rock tile's nine columns to its top block of bedrock
# Run as the tile's marker, at it, two below the ground at its northwestern
#  block

scoreboard players operation #ch_d dr_temp = @s dr_bd
scoreboard players operation #ch_g dr_temp = @s dr_breg
execute positioned ~ ~2 ~ if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~1 ~2 ~ if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~2 ~2 ~ if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~ ~2 ~1 if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~1 ~2 ~1 if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~2 ~2 ~1 if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~ ~2 ~2 if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~1 ~2 ~2 if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
execute positioned ~2 ~2 ~2 if block ~ ~ ~ bedrock run function derailed:dev/big/_chest_top
