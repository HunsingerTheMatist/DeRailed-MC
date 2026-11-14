
# Has the water of this lake tile run toward each southern, western and
#  eastern edge with nothing past it, a void tile or the map's edge, where its
#  waterfall goes down: each block along that edge flows the way of the edges
#  it touches added together, so a corner flows the way between them and edges
#  facing each other cancel out
# A lake's surface is still water, waterlogged walls a block up from the tile's
#  marker; each block that runs is set as the wall that draws that flow
# Run as the lake tile's marker, at it, two below the ground at its
#  northwestern block

scoreboard players set #ls_s dr_temp 0
scoreboard players set #ls_w dr_temp 0
scoreboard players set #ls_e dr_temp 0
execute positioned ~ ~ ~3 unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] run scoreboard players set #ls_s dr_temp 1
execute positioned ~-3 ~ ~ unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] run scoreboard players set #ls_w dr_temp 1
execute positioned ~3 ~ ~ unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] run scoreboard players set #ls_e dr_temp 1

# The western edge, and the eastern
execute if score #ls_w dr_temp matches 1 run fill ~ ~1 ~ ~ ~1 ~1 polished_sulfur_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict
execute if score #ls_e dr_temp matches 1 run fill ~2 ~1 ~ ~2 ~1 ~1 sandstone_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict

# The southern edge, its corners turned toward the western or eastern edge too
#  where that runs as well
execute if score #ls_s dr_temp matches 1 run fill ~ ~1 ~2 ~2 ~1 ~2 sulfur_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict
execute if score #ls_s dr_temp matches 0 if score #ls_w dr_temp matches 1 run setblock ~ ~1 ~2 polished_sulfur_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict
execute if score #ls_s dr_temp matches 0 if score #ls_e dr_temp matches 1 run setblock ~2 ~1 ~2 sandstone_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict
execute if score #ls_s dr_temp matches 1 if score #ls_w dr_temp matches 1 run setblock ~ ~1 ~2 polished_cinnabar_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict
execute if score #ls_s dr_temp matches 1 if score #ls_e dr_temp matches 1 run setblock ~2 ~1 ~2 cinnabar_wall[up=false,north=none,south=none,east=none,west=none,waterlogged=true] strict
