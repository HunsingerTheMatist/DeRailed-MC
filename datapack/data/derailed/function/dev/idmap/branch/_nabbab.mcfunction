# Narrows the region id to 62..65

execute if score #idmap_id dr_var matches 62..63 run function derailed:dev/idmap/branch/_nabbaba
execute if score #idmap_id dr_var matches 64..65 run function derailed:dev/idmap/branch/_nabbabb
