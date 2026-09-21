# Narrows the region id to 60..61

execute if score #idmap_id dr_var matches 60..60 run function derailed:dev/idmap/branch/_nabbaaba
execute if score #idmap_id dr_var matches 61..61 run function derailed:dev/idmap/branch/_nabbaabb
