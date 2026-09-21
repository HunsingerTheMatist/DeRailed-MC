# Narrows the region id to 53..56

execute if score #idmap_id dr_var matches 53..54 run function derailed:dev/idmap/branch/_nababba
execute if score #idmap_id dr_var matches 55..56 run function derailed:dev/idmap/branch/_nababbb
