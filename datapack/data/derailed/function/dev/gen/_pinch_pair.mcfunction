
# Reads, for the box standing on this route cell and the one it came from,
#  whether rock closes either side of it, the box pointing the way the track
#  runs, and counts it as pinched when rock closes both: into the run it is
#  part of, and marked on the cell behind, which is where the box stands
# Left is the box's own left, so it turns with the track at a corner
# Positioned on the cell, with '#gen_back' the way its parent lies and
#  '#trace_x' and '#trace_z' its column and row

scoreboard players set #pinch_l dr_var 0
scoreboard players set #pinch_r dr_var 0

# Parent west, box pointing east: left is north
execute if score #gen_back dr_var matches 1 if block ~ ~ ~-1 gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 1 if block ~-1 ~ ~-1 gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 1 if block ~ ~ ~1 gray_concrete run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 1 if block ~-1 ~ ~1 gray_concrete run scoreboard players set #pinch_r dr_var 1

# Parent east, box pointing west: left is south
execute if score #gen_back dr_var matches 2 if block ~ ~ ~1 gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 2 if block ~1 ~ ~1 gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 2 if block ~ ~ ~-1 gray_concrete run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 2 if block ~1 ~ ~-1 gray_concrete run scoreboard players set #pinch_r dr_var 1

# Parent north, box pointing south: left is east
execute if score #gen_back dr_var matches 3 if block ~1 ~ ~ gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 3 if block ~1 ~ ~-1 gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 3 if block ~-1 ~ ~ gray_concrete run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 3 if block ~-1 ~ ~-1 gray_concrete run scoreboard players set #pinch_r dr_var 1

# Parent south, box pointing north: left is west
execute if score #gen_back dr_var matches 4 if block ~-1 ~ ~ gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 4 if block ~-1 ~ ~1 gray_concrete run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 4 if block ~1 ~ ~ gray_concrete run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 4 if block ~1 ~ ~1 gray_concrete run scoreboard players set #pinch_r dr_var 1

# The section's edges close a side the way rock does: nobody gets round the
#  train past the north or south edge of the map, and nothing is known to stand
#  past the east edge, the section after not being built yet
# The west edge is the section before, and is read as what stands there
execute if score #gen_back dr_var matches 1 if score #trace_z dr_var matches 0 run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 1 if score #trace_z dr_var matches 15 run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 2 if score #trace_z dr_var matches 15 run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 2 if score #trace_z dr_var matches 0 run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 3 if score #trace_x dr_var matches 31 run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 4 if score #trace_x dr_var matches 31 run scoreboard players set #pinch_r dr_var 1

execute if score #pinch_l dr_var matches 1 if score #pinch_r dr_var matches 1 run function derailed:dev/gen/_pinch_hit
execute if score #pinch_l dr_var matches 0 run function derailed:dev/gen/_pinch_close
execute if score #pinch_l dr_var matches 1 if score #pinch_r dr_var matches 0 run function derailed:dev/gen/_pinch_close
