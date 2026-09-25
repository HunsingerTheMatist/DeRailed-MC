
# Chooses which of the four tiles round a corner the water goes on, the same
#  for the whole river: the first, in the order south-east, south-west,
#  north-east, north-west, whose tiles carve no prefab and put no water across
#  the seam into the section before, kept in 'rw' for the stamp
# None of the four fitting leaves '#riv_side' at 0

scoreboard players set #riv_side dr_var 0
data modify storage derailed:gen rw set value {x:0,z:0,minx:-1}
function derailed:dev/gen/_river_side_try
execute if score #riv_side dr_var matches 0 run data modify storage derailed:gen rw set value {x:-1,z:0,minx:0}
execute if score #riv_side dr_var matches 0 run function derailed:dev/gen/_river_side_try
execute if score #riv_side dr_var matches 0 run data modify storage derailed:gen rw set value {x:0,z:-1,minx:-1}
execute if score #riv_side dr_var matches 0 run function derailed:dev/gen/_river_side_try
execute if score #riv_side dr_var matches 0 run data modify storage derailed:gen rw set value {x:-1,z:-1,minx:0}
execute if score #riv_side dr_var matches 0 run function derailed:dev/gen/_river_side_try
