
# Lays the section's pieces on the layer the regions grow on, each with a
#  chance of '#gen_piece_odds' percent: a herd of cows, two wide and one to three tall with a cow on every tile, in
#  hay, and a pair of bandits, two wide and one tall with a bandit on each
#  tile, in red nether bricks
# Each is a patch of ground of its own that nothing grows into, paints, cuts or
#  repaints, placed anywhere clear of the station, its yard and the other piece,
#  and marked 'dr_piece' on its northwestern tile; a piece that finds no room
#  in '#gen_piece_tries' tries is left out
# Positioned at the section's corner

kill @e[type=marker,tag=dr_piece,distance=0..]
data modify storage derailed:gen pieces set value []
scoreboard players set #piece_cows dr_var 0
scoreboard players set #piece_bandits dr_var 0

execute store result score #pc_roll dr_var run random value 1..100
scoreboard players set #pc_coin dr_var 0
execute if score #pc_roll dr_var <= #gen_piece_odds dr_var run scoreboard players set #pc_coin dr_var 1
execute if score #pc_coin dr_var matches 1 store result score #pc_h dr_var run random value 1..3
execute if score #pc_coin dr_var matches 1 run scoreboard players operation #pc_n dr_var = #pc_h dr_var
execute if score #pc_coin dr_var matches 1 run scoreboard players operation #pc_n dr_var *= $Two dr_const
execute if score #pc_coin dr_var matches 1 run data modify storage derailed:gen pc set value {block:"hay_block",glass:"white_stained_glass",tag:"dr_cows"}
execute if score #pc_coin dr_var matches 1 run function derailed:dev/gen/_piece_place
execute if score #pc_coin dr_var matches 1 run scoreboard players operation #piece_cows dr_var = #pc_ok dr_var

execute store result score #pc_roll dr_var run random value 1..100
scoreboard players set #pc_coin dr_var 0
execute if score #pc_roll dr_var <= #gen_piece_odds dr_var run scoreboard players set #pc_coin dr_var 1
execute if score #pc_coin dr_var matches 1 run scoreboard players set #pc_h dr_var 1
execute if score #pc_coin dr_var matches 1 run scoreboard players set #pc_n dr_var 2
execute if score #pc_coin dr_var matches 1 run data modify storage derailed:gen pc set value {block:"red_nether_bricks",glass:"red_stained_glass",tag:"dr_bandits"}
execute if score #pc_coin dr_var matches 1 run function derailed:dev/gen/_piece_place
execute if score #pc_coin dr_var matches 1 run scoreboard players operation #piece_bandits dr_var = #pc_ok dr_var
