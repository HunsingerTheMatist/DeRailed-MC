# Narrows the region id to 8..9

execute if score #idmap_id dr_var matches 8..8 run function derailed:dev/idmap/branch/_naaaabba
execute if score #idmap_id dr_var matches 9..9 run function derailed:dev/idmap/branch/_naaaabbb
