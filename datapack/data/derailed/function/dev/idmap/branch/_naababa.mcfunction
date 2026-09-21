# Narrows the region id to 24..26

execute if score #idmap_id dr_var matches 24..25 run function derailed:dev/idmap/branch/_naababaa
execute if score #idmap_id dr_var matches 26..26 run function derailed:dev/idmap/branch/_naababab
