# Narrows the region id to 51..52

execute if score #idmap_id dr_var matches 51..51 run function derailed:dev/idmap/branch/_nabababa
execute if score #idmap_id dr_var matches 52..52 run function derailed:dev/idmap/branch/_nabababb
