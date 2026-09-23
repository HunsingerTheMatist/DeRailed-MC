
# Reads, for the pair of route cells the trace stands on - this one and the one
#  it came from - whether rock closes either side of the train's box, the box
#  pointing the way the track runs, and with the pair before judges the window
#  the box slides through between them: pinched when rock closes both sides
#  somewhere along it
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
# The west edge never comes up, since the route never runs along the western
#  column
execute if score #gen_back dr_var matches 1 if score #trace_z dr_var matches 0 run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 1 if score #trace_z dr_var matches 15 run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 2 if score #trace_z dr_var matches 15 run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 2 if score #trace_z dr_var matches 0 run scoreboard players set #pinch_r dr_var 1
execute if score #gen_back dr_var matches 3 if score #trace_x dr_var matches 31 run scoreboard players set #pinch_l dr_var 1
execute if score #gen_back dr_var matches 4 if score #trace_x dr_var matches 31 run scoreboard players set #pinch_r dr_var 1

scoreboard players operation #pinch_wl dr_var = #pinch_l dr_var
scoreboard players operation #pinch_wl dr_var += #pinch_pl dr_var
scoreboard players operation #pinch_wr dr_var = #pinch_r dr_var
scoreboard players operation #pinch_wr dr_var += #pinch_pr dr_var
scoreboard players operation #pinch_pl dr_var = #pinch_l dr_var
scoreboard players operation #pinch_pr dr_var = #pinch_r dr_var

execute if score #pinch_wl dr_var matches 1.. if score #pinch_wr dr_var matches 1.. run function derailed:dev/gen/_pinch_hit
execute unless score #pinch_wl dr_var matches 1.. run function derailed:dev/gen/_pinch_close
execute if score #pinch_wl dr_var matches 1.. unless score #pinch_wr dr_var matches 1.. run function derailed:dev/gen/_pinch_close

# Which way this cell's parent lay is what the next cell needs to find this one
#  again, should its window be pinched
scoreboard players operation #pinch_pback dr_var = #gen_back dr_var
