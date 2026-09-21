# Narrows the region id to 0..37

execute if score #idmap_id dr_var matches 0..18 run function derailed:dev/idmap/branch/_naaa
execute if score #idmap_id dr_var matches 19..37 run function derailed:dev/idmap/branch/_naab
