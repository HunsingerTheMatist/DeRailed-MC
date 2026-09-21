# Applies one 35 wide row and steps south to the next

scoreboard players set #idmap_x dr_var 35
function derailed:dev/idmap/macro/_cell
scoreboard players remove #idmap_z dr_var 1
execute if score #idmap_z dr_var matches 1.. positioned ~ ~ ~1 run function derailed:dev/idmap/macro/_row
