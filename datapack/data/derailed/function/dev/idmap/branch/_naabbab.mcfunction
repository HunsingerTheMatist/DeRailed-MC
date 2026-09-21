# Narrows the region id to 32..33

execute if score #idmap_id dr_var matches 32..32 run function derailed:dev/idmap/branch/_naabbaba
execute if score #idmap_id dr_var matches 33..33 run function derailed:dev/idmap/branch/_naabbabb
