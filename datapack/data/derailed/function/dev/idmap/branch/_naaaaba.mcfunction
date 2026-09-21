# Narrows the region id to 5..7

execute if score #idmap_id dr_var matches 5..6 run function derailed:dev/idmap/branch/_naaaabaa
execute if score #idmap_id dr_var matches 7..7 run function derailed:dev/idmap/branch/_naaaabab
