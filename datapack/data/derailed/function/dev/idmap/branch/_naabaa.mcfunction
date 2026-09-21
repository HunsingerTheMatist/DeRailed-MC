# Narrows the region id to 19..23

execute if score #idmap_id dr_var matches 19..21 run function derailed:dev/idmap/branch/_naabaaa
execute if score #idmap_id dr_var matches 22..23 run function derailed:dev/idmap/branch/_naabaab
