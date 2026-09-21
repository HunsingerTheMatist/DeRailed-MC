# Applies one tile through the 'branch' mapping and steps east to the next

execute store result score #idmap_id dr_var run random value 0..149
function derailed:dev/idmap/branch/_n
scoreboard players remove #idmap_x dr_var 1
execute if score #idmap_x dr_var matches 1.. positioned ~1 ~ ~ run function derailed:dev/idmap/branch/_cell
