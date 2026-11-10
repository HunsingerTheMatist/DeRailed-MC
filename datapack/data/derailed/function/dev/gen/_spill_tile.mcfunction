
# Leaves this tile, on column $(x) and $(z) rows south of the entry row, for the
#  start station's ground to reach on the wave it would from the nearest of its
#  three points
# Positioned at the tile

$scoreboard players set #sx dr_temp $(x)
$scoreboard players set #sz dr_temp $(z)
scoreboard players operation #sz dr_temp += #gen_entry dr_var

scoreboard players operation #gx dr_temp = #sx dr_temp
scoreboard players operation #gx dr_temp -= #spill_x1 dr_var
scoreboard players operation #gz dr_temp = #sz dr_temp
scoreboard players operation #gz dr_temp -= #spill_z1 dr_var
function derailed:dev/gen/_grow_waves
scoreboard players operation #sw dr_temp = #gw dr_temp
scoreboard players operation #gx dr_temp = #sx dr_temp
scoreboard players operation #gx dr_temp -= #spill_x2 dr_var
scoreboard players operation #gz dr_temp = #sz dr_temp
scoreboard players operation #gz dr_temp -= #spill_z2 dr_var
function derailed:dev/gen/_grow_waves
scoreboard players operation #sw dr_temp < #gw dr_temp
scoreboard players operation #gx dr_temp = #sx dr_temp
scoreboard players operation #gx dr_temp -= #spill_x3 dr_var
scoreboard players operation #gz dr_temp = #sz dr_temp
scoreboard players operation #gz dr_temp -= #spill_z3 dr_var
function derailed:dev/gen/_grow_waves
scoreboard players operation #sw dr_temp < #gw dr_temp

execute store result storage derailed:gen v.wake int 1 run scoreboard players get #sw dr_temp
function derailed:dev/gen/_spill_at with storage derailed:gen v
