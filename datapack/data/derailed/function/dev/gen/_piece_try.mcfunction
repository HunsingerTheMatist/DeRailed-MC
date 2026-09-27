
# Tries the piece in 'pc' at a spot taken at random, in from the yard's two
#  columns and short of the station's four, and lays it there if every tile is
#  clear, otherwise tries again while tries are left
# Positioned at the section's corner

scoreboard players remove #pc_tries dr_var 1
execute store result score #pc_x dr_var run random value 2..26
execute store result score #pc_z dr_var run random value 0..15
scoreboard players operation #pc_zl dr_var = #pc_z dr_var
scoreboard players operation #pc_zl dr_var += #pc_h dr_var
scoreboard players remove #pc_zl dr_var 1

execute store result storage derailed:gen pc.x int 1 run scoreboard players get #pc_x dr_var
execute store result storage derailed:gen pc.x1 int 1 run scoreboard players add #pc_x dr_var 1
execute store result storage derailed:gen pc.z int 1 run scoreboard players get #pc_z dr_var
execute store result storage derailed:gen pc.z1 int 1 run scoreboard players add #pc_z dr_var 1
execute store result storage derailed:gen pc.z2 int 1 run scoreboard players add #pc_z dr_var 1
execute store result storage derailed:gen pc.zl int 1 run scoreboard players get #pc_zl dr_var

execute if score #pc_zl dr_var matches ..15 store result score #pc_ok dr_var run function derailed:dev/gen/_piece_fits with storage derailed:gen pc
execute if score #pc_ok dr_var matches 1 run return run function derailed:dev/gen/_piece_lay with storage derailed:gen pc
execute if score #pc_tries dr_var matches 1.. run function derailed:dev/gen/_piece_try
