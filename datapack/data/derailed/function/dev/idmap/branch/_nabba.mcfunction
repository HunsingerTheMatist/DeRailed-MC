# Narrows the region id to 57..65

execute if score #idmap_id dr_var matches 57..61 run function derailed:dev/idmap/branch/_nabbaa
execute if score #idmap_id dr_var matches 62..65 run function derailed:dev/idmap/branch/_nabbab
