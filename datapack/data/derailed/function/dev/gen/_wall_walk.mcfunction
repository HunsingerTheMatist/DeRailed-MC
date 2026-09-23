
# Steps from this seed to the nearest seed south of it, and runs the band down
#  to the border instead once it stands in the last rows, has stepped as far as
#  it may, or finds no seed to step to
# Run as the seed, positioned on it

scoreboard players remove #gen_steps dr_var 1

execute store result score #wall_lx dr_var run data get entity @s Pos[0]
execute store result score #wall_lz dr_var run data get entity @s Pos[2]
scoreboard players operation #wall_row dr_var = #wall_lz dr_var
scoreboard players operation #wall_row dr_var -= #gen_cz dr_var
execute if score #gen_steps dr_var matches ..0 run return run function derailed:dev/gen/_wall_end
execute if score #wall_row dr_var matches 12.. run return run function derailed:dev/gen/_wall_end

# A window eight rows deep starting on the row below, and six columns either
#  side, so that the band leans no further sideways than it has to
scoreboard players operation #wall_z dr_var = #wall_lz dr_var
scoreboard players add #wall_z dr_var 1
execute store result storage derailed:gen w.z int 1 run scoreboard players get #wall_z dr_var
scoreboard players operation #wall_x dr_var = #wall_lx dr_var
scoreboard players remove #wall_x dr_var 6
execute store result storage derailed:gen w.x int 1 run scoreboard players get #wall_x dr_var

# Whether any seed joined from the window is read off a flag that joining sets;
#  it is set on the way out as well, so that the seed before does not read the
#  end of the band as its own to run
scoreboard players set #wall_went dr_var 0
function derailed:dev/gen/_wall_next with storage derailed:gen w
execute if score #wall_went dr_var matches 0 run function derailed:dev/gen/_wall_end
scoreboard players set #wall_went dr_var 1
