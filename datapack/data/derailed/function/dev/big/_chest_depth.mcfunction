
# Gives '#ch_k' as its depth to every rock tile still without one that has a
#  tile '#ch_k' less deep beside it along a side, then does the same one deeper
#  while any is left: a tile that is not rock, or no tile at all past the
#  section's edge, being none deep

execute as @e[type=marker,tag=dr_big_rock,scores={dr_bd=0},distance=0..] at @s run function derailed:dev/big/_chest_depth_at
scoreboard players add #ch_k dr_temp 1
execute if score #ch_k dr_temp matches ..32 if entity @e[type=marker,tag=dr_big_rock,scores={dr_bd=0},distance=0..] run function derailed:dev/big/_chest_depth
