
# Sets the blocks this resource pile stands in, so players bump into it rather
#  than walking through it, each a pixel short of the top of the pile's 9 pixel
#  layers and all drawn as nothing: a cake under one, not a full face
#  underneath, so the ground keeps its top face; pink stained glass, which
#  hides no face but another glass's, for each whole block under two or more,
#  topped by a white carpet for two, snow 6 layers deep for three, a spruce
#  trapdoor for four and snow 7 layers deep for five; a column of three glass
#  for six or more; none once it is empty
# Run as the placement's interaction entity, at it

execute if score @s dr_count matches 6.. run \
    return run fill ~ ~ ~ ~ ~2 ~ pink_stained_glass strict

fill ~ ~ ~ ~ ~2 ~ air replace #derailed:pile_collision strict
execute if score @s dr_count matches 1 run setblock ~ ~ ~ cake strict
execute if score @s dr_count matches 2 run setblock ~ ~1 ~ white_carpet strict
execute if score @s dr_count matches 3 run setblock ~ ~1 ~ snow[layers=6] strict
execute if score @s dr_count matches 4 run setblock ~ ~2 ~ spruce_trapdoor strict
execute if score @s dr_count matches 5 run setblock ~ ~2 ~ snow[layers=7] strict
execute if score @s dr_count matches 2.. run setblock ~ ~ ~ pink_stained_glass strict
execute if score @s dr_count matches 4.. run setblock ~ ~1 ~ pink_stained_glass strict
