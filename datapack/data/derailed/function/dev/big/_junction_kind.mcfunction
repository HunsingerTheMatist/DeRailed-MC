
# Tags this river tile's marker 'dr_big_junction' where it is fed one way and
#  leaves two, a split, or is fed two ways and leaves one, a merge, and keeps
#  the piece it is laid with in its data, 'j', as 'kind', 'a' and 'b': split or
#  merge, the ways it is fed and the ways it leaves, in the order north, east,
#  south, west
# Run as the tile's marker

scoreboard players set #j_in dr_temp 0
execute if entity @s[tag=dr_big_in_n] run scoreboard players add #j_in dr_temp 1
execute if entity @s[tag=dr_big_in_e] run scoreboard players add #j_in dr_temp 1
execute if entity @s[tag=dr_big_in_s] run scoreboard players add #j_in dr_temp 1
execute if entity @s[tag=dr_big_in_w] run scoreboard players add #j_in dr_temp 1
scoreboard players set #j_out dr_temp 0
execute if entity @s[tag=dr_big_out_n] run scoreboard players add #j_out dr_temp 1
execute if entity @s[tag=dr_big_out_e] run scoreboard players add #j_out dr_temp 1
execute if entity @s[tag=dr_big_out_s] run scoreboard players add #j_out dr_temp 1
execute if entity @s[tag=dr_big_out_w] run scoreboard players add #j_out dr_temp 1
execute if score #j_in dr_temp matches 1 if score #j_out dr_temp matches 1 run return run function derailed:dev/big/_junction_split
execute if score #j_in dr_temp matches 2 if score #j_out dr_temp matches 0 run function derailed:dev/big/_junction_merge
