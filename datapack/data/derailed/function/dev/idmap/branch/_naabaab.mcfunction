# Narrows the region id to 22..23

execute if score #idmap_id dr_var matches 22..22 run function derailed:dev/idmap/branch/_naabaaba
execute if score #idmap_id dr_var matches 23..23 run function derailed:dev/idmap/branch/_naabaabb
