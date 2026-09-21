# Narrows the region id to 62..63

execute if score #idmap_id dr_var matches 62..62 run function derailed:dev/idmap/branch/_nabbabaa
execute if score #idmap_id dr_var matches 63..63 run function derailed:dev/idmap/branch/_nabbabab
