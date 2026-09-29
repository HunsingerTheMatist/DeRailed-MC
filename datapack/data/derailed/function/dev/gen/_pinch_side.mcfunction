
# Counts the rock either side of this tile of a pinched box, the sides being
#  the box's own where the track runs through here, and a side that faces out
#  of the section as a hundred, since the edge closes it and cannot be cut
# Run as the box's marker, positioned on the tile, with '#pinch_col' and
#  '#pinch_row' the tile's column and row

# Box pointing east: left is north
execute if score @s dr_dir matches 1 if block ~ ~ ~-1 gray_concrete run scoreboard players add #pinch_lrock dr_var 1
execute if score @s dr_dir matches 1 if score #pinch_row dr_var matches 0 run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 1 if block ~ ~ ~1 gray_concrete run scoreboard players add #pinch_rrock dr_var 1
execute if score @s dr_dir matches 1 if score #pinch_row dr_var matches 15 run scoreboard players add #pinch_rrock dr_var 100

# Box pointing west: left is south
execute if score @s dr_dir matches 2 if block ~ ~ ~1 gray_concrete run scoreboard players add #pinch_lrock dr_var 1
execute if score @s dr_dir matches 2 if score #pinch_row dr_var matches 15 run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 2 if block ~ ~ ~-1 gray_concrete run scoreboard players add #pinch_rrock dr_var 1
execute if score @s dr_dir matches 2 if score #pinch_row dr_var matches 0 run scoreboard players add #pinch_rrock dr_var 100

# Box pointing south: left is east
execute if score @s dr_dir matches 3 if block ~1 ~ ~ gray_concrete run scoreboard players add #pinch_lrock dr_var 1
execute if score @s dr_dir matches 3 if score #pinch_col dr_var matches 31 run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 3 if block ~-1 ~ ~ gray_concrete run scoreboard players add #pinch_rrock dr_var 1

# Box pointing north: left is west
execute if score @s dr_dir matches 4 if block ~-1 ~ ~ gray_concrete run scoreboard players add #pinch_lrock dr_var 1
execute if score @s dr_dir matches 4 if block ~1 ~ ~ gray_concrete run scoreboard players add #pinch_rrock dr_var 1
execute if score @s dr_dir matches 4 if score #pinch_col dr_var matches 31 run scoreboard players add #pinch_rrock dr_var 100

# The station's building counts as a hundred, since it is never cut
execute if score @s dr_dir matches 1 if block ~ ~ ~-1 gray_concrete if block ~ ~-15 ~-1 #derailed:prefab run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 1 if block ~ ~ ~1 gray_concrete if block ~ ~-15 ~1 #derailed:prefab run scoreboard players add #pinch_rrock dr_var 100
execute if score @s dr_dir matches 2 if block ~ ~ ~1 gray_concrete if block ~ ~-15 ~1 #derailed:prefab run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 2 if block ~ ~ ~-1 gray_concrete if block ~ ~-15 ~-1 #derailed:prefab run scoreboard players add #pinch_rrock dr_var 100
execute if score @s dr_dir matches 3 if block ~1 ~ ~ gray_concrete if block ~1 ~-15 ~ #derailed:prefab run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 3 if block ~-1 ~ ~ gray_concrete if block ~-1 ~-15 ~ #derailed:prefab run scoreboard players add #pinch_rrock dr_var 100
execute if score @s dr_dir matches 4 if block ~-1 ~ ~ gray_concrete if block ~-1 ~-15 ~ #derailed:prefab run scoreboard players add #pinch_lrock dr_var 100
execute if score @s dr_dir matches 4 if block ~1 ~ ~ gray_concrete if block ~1 ~-15 ~ #derailed:prefab run scoreboard players add #pinch_rrock dr_var 100

# Rock in the section before, west of the western column, counts as a hundred
#  too, since nothing there is ever cut
execute if score @s dr_dir matches 3 if score #pinch_col dr_var matches 0 if block ~-1 ~ ~ gray_concrete run scoreboard players add #pinch_rrock dr_var 100
execute if score @s dr_dir matches 4 if score #pinch_col dr_var matches 0 if block ~-1 ~ ~ gray_concrete run scoreboard players add #pinch_lrock dr_var 100

# For the second route, rock beside the first route or in the zone round its
#  pinches counts as a hundred as well, since it is never opened
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 1 if block ~ ~ ~-1 gray_concrete if block ~ ~3 ~-1 #derailed:second_band run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 1 if block ~ ~ ~-1 gray_concrete if block ~ ~3 ~-1 #derailed:second_zone run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 1 if block ~ ~ ~1 gray_concrete if block ~ ~3 ~1 #derailed:second_band run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 1 if block ~ ~ ~1 gray_concrete if block ~ ~3 ~1 #derailed:second_zone run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 2 if block ~ ~ ~1 gray_concrete if block ~ ~3 ~1 #derailed:second_band run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 2 if block ~ ~ ~1 gray_concrete if block ~ ~3 ~1 #derailed:second_zone run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 2 if block ~ ~ ~-1 gray_concrete if block ~ ~3 ~-1 #derailed:second_band run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 2 if block ~ ~ ~-1 gray_concrete if block ~ ~3 ~-1 #derailed:second_zone run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 3 if block ~1 ~ ~ gray_concrete if block ~1 ~3 ~ #derailed:second_band run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 3 if block ~1 ~ ~ gray_concrete if block ~1 ~3 ~ #derailed:second_zone run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 3 if block ~-1 ~ ~ gray_concrete if block ~-1 ~3 ~ #derailed:second_band run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 3 if block ~-1 ~ ~ gray_concrete if block ~-1 ~3 ~ #derailed:second_zone run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 4 if block ~-1 ~ ~ gray_concrete if block ~-1 ~3 ~ #derailed:second_band run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 4 if block ~-1 ~ ~ gray_concrete if block ~-1 ~3 ~ #derailed:second_zone run scoreboard players add #pinch_lrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 4 if block ~1 ~ ~ gray_concrete if block ~1 ~3 ~ #derailed:second_band run scoreboard players add #pinch_rrock dr_var 100
execute if score #cost_mode dr_var matches 1 if score @s dr_dir matches 4 if block ~1 ~ ~ gray_concrete if block ~1 ~3 ~ #derailed:second_zone run scoreboard players add #pinch_rrock dr_var 100
