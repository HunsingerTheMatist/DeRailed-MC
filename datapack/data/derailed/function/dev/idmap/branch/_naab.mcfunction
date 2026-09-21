# Narrows the region id to 19..37

execute if score #idmap_id dr_var matches 19..28 run function derailed:dev/idmap/branch/_naaba
execute if score #idmap_id dr_var matches 29..37 run function derailed:dev/idmap/branch/_naabb
