# Applies one tile through the 'macro' mapping and steps east to the next

execute store result storage derailed:idmap args.id int 1 run random value 0..149
function derailed:dev/idmap/macro/_lookup with storage derailed:idmap args
function derailed:dev/idmap/macro/_apply with storage derailed:idmap args
scoreboard players remove #idmap_x dr_var 1
execute if score #idmap_x dr_var matches 1.. positioned ~1 ~ ~ run function derailed:dev/idmap/macro/_cell
