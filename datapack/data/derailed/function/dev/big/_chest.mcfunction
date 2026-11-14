
# Hides chests in the section's rock, one on easy and two on medium and hard
#  ('$Difficulty'), each on the top block of a rock column: every rock column is
#  measured to its top block of bedrock, slabs left out, and a chest may go on
#  one within two blocks of the height 90% of the way up from the lowest to the
#  highest, where two changes or fewer to the rock beside it give it the sides
#  its difficulty asks for ('_chest_fit'); columns are tried one at a time,
#  each taken at random with those of a tile weighed by how deep in the rock it
#  is, and the first that fits is taken, the heights widening a block either
#  way at a time while none does
# Two chests stand on different regions, 30 blocks or more apart across the
#  ground, a first that has no second that far being passed over; where no two
#  can be that far apart they may be 20, and where not even that, the section
#  has one, and says so
# Takes its random numbers from nothing fixed, so each build hides them
#  somewhere new, or from 'derailed:terrain' where '#big_chest_seeded' is 1
# Run in the game's dimension

scoreboard players set @e[type=marker,tag=dr_big_rock,distance=0..] dr_bd 0
scoreboard players set #ch_k dr_temp 1
function derailed:dev/big/_chest_depth
execute as @e[type=marker,tag=dr_big_rock,distance=0..] at @s run function derailed:dev/big/_chest_cols
function derailed:dev/big/_chest_find
kill @e[type=marker,tag=dr_big_col,distance=0..]
