
# Has this river tile flow the way '#s_n', 0 north, 1 east, 2 south and 3 west
# Run as the river tile's marker

tag @s remove dr_big_n
tag @s remove dr_big_e
tag @s remove dr_big_s
tag @s remove dr_big_w
execute if score #s_n dr_temp matches 0 run tag @s add dr_big_n
execute if score #s_n dr_temp matches 1 run tag @s add dr_big_e
execute if score #s_n dr_temp matches 2 run tag @s add dr_big_s
execute if score #s_n dr_temp matches 3 run tag @s add dr_big_w
