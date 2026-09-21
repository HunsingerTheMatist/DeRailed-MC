# Narrows the region id to 43..47

execute if score #idmap_id dr_var matches 43..45 run function derailed:dev/idmap/branch/_nabaaba
execute if score #idmap_id dr_var matches 46..47 run function derailed:dev/idmap/branch/_nabaabb
