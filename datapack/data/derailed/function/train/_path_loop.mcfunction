# Where team $(team)'s path is a loop, adds another round of it once its
#  frontmost axle, on tile '#hi', comes within 16 tiles of its end

$execute unless data storage derailed:train t$(team).loop[0] run return 0
$execute store result score #n dr_temp run data get storage derailed:train t$(team).path
scoreboard players remove #n dr_temp 16
$execute if score #hi dr_temp >= #n dr_temp run data modify storage derailed:train t$(team).path append from storage derailed:train t$(team).loop[]
