
# Counts into '#ch_s' the blocks from here to the side of the mountain, $(x)
#  $(z) a step, the side being the first column with no rock at the ground at
#  y15 that is ground to stand on; a step onto the void or off the map, with
#  nothing at y14, finds no side that way, 999
# Positioned at the chest's top block

scoreboard players add #ch_s dr_temp 1
$execute if score #ch_s dr_temp matches ..95 if block ~$(x) 15 ~$(z) bedrock positioned ~$(x) ~ ~$(z) run return run function derailed:dev/big/_chest_side {x:$(x),z:$(z)}
$execute if block ~$(x) 14 ~$(z) air run scoreboard players set #ch_s dr_temp 999
