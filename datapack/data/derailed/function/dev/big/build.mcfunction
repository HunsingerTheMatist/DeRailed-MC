
# Builds the large version of section '#big_section' of the test map, three by
#  three blocks to a tile, from 1100 15 0 southeast: the ground, rivers and
#  lakes first, then the station and, in the first section, the start station
#  with its seven rails, then the trees and mounds of iron and rock over the
#  stations' overhang; the void is left empty and the map's edges open, so a
#  player can fall off either
# The same section always comes out the same, from '#big_seed' moved on by the
#  section's number
# Positions itself, so it is safe to call from anywhere

scoreboard objectives add dr_bx dummy "DeRailed Big Tile Column"
scoreboard objectives add dr_bz dummy "DeRailed Big Tile Row"
scoreboard objectives add dr_brun dummy "DeRailed Big Cut Run"
scoreboard objectives add dr_bord dummy "DeRailed Big Cut Order"
scoreboard objectives add dr_bh dummy "DeRailed Big Column Height"
scoreboard objectives add dr_bd dummy "DeRailed Big Rock Depth"

scoreboard players operation #big_x dr_temp = #big_section dr_var
scoreboard players operation #big_x dr_temp *= $SectionWidth dr_const
execute store result storage derailed:big s.x int 1 run scoreboard players add #big_x dr_temp 968
scoreboard players operation #big_s dr_temp = #big_seed dr_var
execute store result storage derailed:big s.seed int 1 run scoreboard players operation #big_s dr_temp += #big_section dr_var
execute in derailed:game run function derailed:dev/big/_at with storage derailed:big s
