
# Numbers every tile of the run beside one numbered '#big_k' one more, then goes
#  on while the run has tiles left to number

scoreboard players operation #big_k1 dr_temp = #big_k dr_temp
scoreboard players add #big_k1 dr_temp 1
execute as @e[type=marker,tag=dr_big_in,distance=0..] if score @s dr_bord = #big_k dr_temp at @s run function derailed:dev/big/_cut_next
scoreboard players add #big_k dr_temp 1
execute if score #big_k dr_temp < #big_n dr_temp run function derailed:dev/big/_cut_walk
