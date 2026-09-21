# Narrows the region id to 27..28

execute if score #idmap_id dr_var matches 27..27 run function derailed:dev/idmap/branch/_naababba
execute if score #idmap_id dr_var matches 28..28 run function derailed:dev/idmap/branch/_naababbb
