# Narrows the region id to 24..28

execute if score #idmap_id dr_var matches 24..26 run function derailed:dev/idmap/branch/_naababa
execute if score #idmap_id dr_var matches 27..28 run function derailed:dev/idmap/branch/_naababb
