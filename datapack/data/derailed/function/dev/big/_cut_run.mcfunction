
# Works out which way run '#big_r' flows, its tiles tagged 'dr_big_in' while it
#  is worked on: it starts from a tile beside a river where the run has a river
#  at one end and a lake at the other, and otherwise from any tile beside water,
#  the westernmost and then the northernmost of them, and is numbered in
#  'dr_bord' from there along the run

tag @e[type=marker,tag=dr_big_in,distance=0..] remove dr_big_in
execute as @e[type=marker,tag=dr_big_cut,distance=0..] if score @s dr_brun = #big_r dr_temp run tag @s add dr_big_in

scoreboard players set #big_both dr_temp 0
execute if entity @e[type=marker,tag=dr_big_in,tag=dr_big_end_riv,distance=0..] if entity @e[type=marker,tag=dr_big_in,tag=dr_big_end_lake,distance=0..] run scoreboard players set #big_both dr_temp 1

tag @e[type=marker,tag=dr_big_in,tag=dr_big_end_riv,distance=0..] add dr_big_from
execute if score #big_both dr_temp matches 0 run tag @e[type=marker,tag=dr_big_in,tag=dr_big_end_lake,distance=0..] add dr_big_from
execute unless entity @e[type=marker,tag=dr_big_from,distance=0..] run tag @e[type=marker,tag=dr_big_in,distance=0..] add dr_big_from
scoreboard players set #big_min dr_temp 2147483647
execute as @e[type=marker,tag=dr_big_from,distance=0..] run scoreboard players operation #big_min dr_temp < @s dr_bx
execute as @e[type=marker,tag=dr_big_from,distance=0..] unless score @s dr_bx = #big_min dr_temp run tag @s remove dr_big_from
scoreboard players set #big_min dr_temp 2147483647
execute as @e[type=marker,tag=dr_big_from,distance=0..] run scoreboard players operation #big_min dr_temp < @s dr_bz
execute as @e[type=marker,tag=dr_big_from,distance=0..] unless score @s dr_bz = #big_min dr_temp run tag @s remove dr_big_from
scoreboard players set @e[type=marker,tag=dr_big_from,distance=0..] dr_bord 1
tag @e[type=marker,tag=dr_big_from,distance=0..] remove dr_big_from

execute store result score #big_n dr_temp if entity @e[type=marker,tag=dr_big_in,distance=0..]
scoreboard players set #big_k dr_temp 1
execute if score #big_n dr_temp matches 2.. run function derailed:dev/big/_cut_walk
execute as @e[type=marker,tag=dr_big_in,distance=0..] at @s run function derailed:dev/big/_cut_aim
