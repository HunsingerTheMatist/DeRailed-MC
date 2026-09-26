
# Lays one band from a random column of the north border, and lays another from
#  a fresh column while one is left to try if this one has a hole in it or
#  takes too many regions
# A region carried over the seam keeps the kind it came with and has no seed
#  here to put on the band, so the band has a hole wherever it runs through one
#  that is not rock already
# Positioned at the section's corner

scoreboard players remove #wall_tries dr_var 1

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_wall
scoreboard players set #wall_gap dr_var 0
scoreboard players set #wall_went dr_var 0

execute store result storage derailed:gen w.x int 1 run random value 2..29
scoreboard players set #gen_steps dr_var 8
function derailed:dev/gen/_wall_start with storage derailed:gen w

# No seed within reach of the border point leaves no band at all
execute if score #wall_went dr_var matches 0 run scoreboard players add #wall_gap dr_var 1

# A band that takes so many regions that the rest cannot hold the other
#  floors is laid again the same way
function derailed:dev/gen/_wall_fits

execute if score #wall_gap dr_var matches 0 if score #wall_big dr_var matches 0 run return 0
execute if score #wall_tries dr_var matches 1.. run return run function derailed:dev/gen/_wall_try

# Out of tries, the last band stands as it is and what is wrong with it is
#  counted
execute if score #wall_gap dr_var matches 1.. run scoreboard players add #gen_wall_gaps dr_var 1
execute if score #wall_big dr_var matches 1 run scoreboard players add #gen_wall_big dr_var 1
