# Narrows the region id to 48..49

execute if score #idmap_id dr_var matches 48..48 run function derailed:dev/idmap/branch/_nababaaaa
execute if score #idmap_id dr_var matches 49..49 run function derailed:dev/idmap/branch/_nababaaab
