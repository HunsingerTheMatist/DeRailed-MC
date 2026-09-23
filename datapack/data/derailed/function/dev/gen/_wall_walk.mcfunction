
# Steps from this seed to the nearest seed south of it, and stops once the band
#  has reached the last rows
# Run as the seed, positioned on it

scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail

execute store result score #wall_z dr_var run data get entity @s Pos[2]
scoreboard players operation #wall_row dr_var = #wall_z dr_var
scoreboard players operation #wall_row dr_var -= #gen_cz dr_var
execute if score #wall_row dr_var matches 12.. run return 0

# A window eight rows deep starting on the row below, and six columns either
#  side, so that the band leans no further sideways than it has to
scoreboard players add #wall_z dr_var 1
execute store result storage derailed:gen w.z int 1 run scoreboard players get #wall_z dr_var
execute store result score #wall_x dr_var run data get entity @s Pos[0]
scoreboard players remove #wall_x dr_var 6
execute store result storage derailed:gen w.x int 1 run scoreboard players get #wall_x dr_var
function derailed:dev/gen/_wall_next with storage derailed:gen w
