# Narrows the region id to 48..50

execute if score #idmap_id dr_var matches 48..49 run function derailed:dev/idmap/branch/_nababaaa
execute if score #idmap_id dr_var matches 50..50 run function derailed:dev/idmap/branch/_nababaab
