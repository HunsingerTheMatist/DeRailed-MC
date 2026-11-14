# Gives off one gold mote above this chest that glides down into it, as an
#  ender chest's own do: it starts from 0.35 to 1.25 blocks out from the middle
#  of the chest's block, the way out taken at random, and from 1 to 2 blocks up
#  from its bottom, where it is always over the rock round the chest, and comes
#  to the middle of the block in 2 seconds ('_sparkle_at')
# Run as the chest's 'dr_chest_spark' marker, at it, in the middle of the
#  chest's block

execute store result entity @s Rotation[0] float 1 run random value 0..359
execute store result storage derailed:chest spark.r double 0.01 run random value 35..125
execute store result storage derailed:chest spark.h double 0.01 run random value 50..150
data modify storage derailed:chest spark.x set from entity @s Pos[0]
data modify storage derailed:chest spark.y set from entity @s Pos[1]
data modify storage derailed:chest spark.z set from entity @s Pos[2]
function derailed:ender_chest/_sparkle_at with storage derailed:chest spark
