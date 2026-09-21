
# Steps from this seed to the next one along, leaning toward the exit row
# The lean is in the shape of the search window rather than in where the search
#  measures from, so the nearest seed really is the nearest one

execute store result storage derailed:gen r.x int 1 run data get entity @s Pos[0]
execute store result score #gen_z dr_var run data get entity @s Pos[2]

scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail

# A window 14 deep, sitting 10 of that on the side the exit lies
scoreboard players operation #gen_zbox dr_var = #gen_z dr_var
execute if score #gen_z dr_var < #gen_exit_z dr_var run scoreboard players remove #gen_zbox dr_var 4
execute unless score #gen_z dr_var < #gen_exit_z dr_var run scoreboard players remove #gen_zbox dr_var 10
execute store result storage derailed:gen r.z int 1 run scoreboard players get #gen_zbox dr_var

execute at @s run function derailed:dev/gen/_next with storage derailed:gen r
