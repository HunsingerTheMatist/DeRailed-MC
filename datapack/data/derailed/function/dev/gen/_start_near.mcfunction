
# Returns 1 where the start station's points $(a) and $(b) are under 2.1 apart,
#  and 0 where they are not

$scoreboard players operation #gx dr_temp = #spill_x$(a) dr_var
$scoreboard players operation #gx dr_temp -= #spill_x$(b) dr_var
$scoreboard players operation #gz dr_temp = #spill_z$(a) dr_var
$scoreboard players operation #gz dr_temp -= #spill_z$(b) dr_var
scoreboard players operation #gx dr_temp *= #gx dr_temp
scoreboard players operation #gz dr_temp *= #gz dr_temp
scoreboard players operation #gx dr_temp += #gz dr_temp
execute if score #gx dr_temp matches ..4 run return 1
return 0
