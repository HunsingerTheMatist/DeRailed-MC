
# Takes into '#sq' which square way this piece faces, 0 for a facing of 0, 1 for
#  90, 2 for 180 and 3 for -90, or -1 for none of them
# Local offsets are worked out from a table of sines that is out by up to a
#  ten-thousandth of a block, so a piece facing a square way places itself and
#  its parts by plain offsets, which come out exact
# Run as the piece's item display

scoreboard players set #sq dr_temp -1
execute if entity @s[y_rotation=-0.01..0.01] run scoreboard players set #sq dr_temp 0
execute if entity @s[y_rotation=89.99..90.01] run scoreboard players set #sq dr_temp 1
execute if entity @s[y_rotation=179.99..-179.99] run scoreboard players set #sq dr_temp 2
execute if entity @s[y_rotation=-90.01..-89.99] run scoreboard players set #sq dr_temp 3
