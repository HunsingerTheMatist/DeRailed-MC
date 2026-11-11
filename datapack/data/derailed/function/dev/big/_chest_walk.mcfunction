
# Takes this column for the chest, tagged 'dr_big_chest_at', where its tile's
#  depth reaches past what is left of '#ch_r', and otherwise takes its depth off
#  '#ch_r'; once a column is taken '#ch_r' stays below nothing
# Run as each column it may go on in turn

execute if score #ch_r dr_temp matches ..-1 run return 0
scoreboard players operation #ch_r dr_temp -= @s dr_bd
execute if score #ch_r dr_temp matches ..-1 run tag @s add dr_big_chest_at
