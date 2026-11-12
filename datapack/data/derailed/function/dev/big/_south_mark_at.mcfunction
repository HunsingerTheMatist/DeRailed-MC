
# Takes this river tile into the stretch being followed
# Run as the river tile's marker

tag @s add dr_big_seg
scoreboard players operation #s_r1 dr_temp = @s dr_bz
scoreboard players operation #s_d dr_temp = @s dr_bdir
