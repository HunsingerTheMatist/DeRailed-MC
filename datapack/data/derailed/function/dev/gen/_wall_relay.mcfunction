
# Builds the section again from its regions as they grew, for an attempt after
#  it has twice found no second way: the regions are put back from where
#  growing them left a copy, and the wall, the rivers and the stray sweep are
#  done again in the order they were done the first time, so that everything
#  after the seeds is fresh; and counts it
# Positioned at the section's corner

function derailed:dev/gen/_lay_restore
clone ~ ~12 ~ ~31 ~12 ~15 ~ ~ ~ strict
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_lake

execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/wall
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict
execute if score #gen_rivers dr_var matches 1 run function derailed:dev/gen/rivers
fill ~ ~16 ~ ~31 ~16 ~15 air replace light_blue_stained_glass strict
function derailed:dev/gen/strays

execute if score #gen_difficulty dr_var matches 2 run scoreboard players add #gen_wall_relaid dr_var 1
