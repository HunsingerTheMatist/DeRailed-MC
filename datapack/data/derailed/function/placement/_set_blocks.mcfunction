
# Sets the blocks this resource pile stands in, so players bump into it rather
#  than walking through it: a cake under one, half a block high and not a
#  full face underneath, so the ground keeps its top face, a barrier with a
#  white carpet on it under two, and a column of three barriers under three or
#  more, the cake and the carpet drawn as nothing; none once it is empty
# Run as the placement's interaction entity, at it

fill ~ ~ ~ ~ ~2 ~ air replace #derailed:pile_collision strict
execute if score @s dr_count matches 1 run setblock ~ ~ ~ cake strict
execute if score @s dr_count matches 2 run setblock ~ ~ ~ barrier strict
execute if score @s dr_count matches 2 run setblock ~ ~1 ~ white_carpet strict
execute if score @s dr_count matches 3.. run fill ~ ~ ~ ~ ~2 ~ barrier strict
