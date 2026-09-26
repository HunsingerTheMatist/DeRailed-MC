
# Leaves '#wall_big' at 1 when the band takes so many regions that the seeds
#  left over cannot hold every other floor, what is still owed to rock
#  included

execute store result score #wall_n dr_var if entity @e[type=marker,tag=dr_seed,tag=dr_wall,distance=0..]
execute store result score #wall_left dr_var if entity @e[type=marker,tag=dr_seed,tag=!dr_wall,distance=0..]
scoreboard players operation #wall_owed dr_var = #gen_min_rock dr_var
scoreboard players operation #wall_owed dr_var -= #wall_n dr_var
execute if score #wall_owed dr_var matches ..-1 run scoreboard players set #wall_owed dr_var 0
scoreboard players operation #wall_owed dr_var += #gen_min_wood dr_var
scoreboard players operation #wall_owed dr_var += #gen_min_iron dr_var
scoreboard players operation #wall_owed dr_var += #gen_min_water dr_var
scoreboard players set #wall_big dr_var 0
execute if score #wall_left dr_var < #wall_owed dr_var run scoreboard players set #wall_big dr_var 1
