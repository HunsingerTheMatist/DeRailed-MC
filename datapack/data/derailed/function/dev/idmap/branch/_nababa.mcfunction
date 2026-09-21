# Narrows the region id to 48..52

execute if score #idmap_id dr_var matches 48..50 run function derailed:dev/idmap/branch/_nababaa
execute if score #idmap_id dr_var matches 51..52 run function derailed:dev/idmap/branch/_nababab
