# Narrows the region id to 128..131

execute if score #idmap_id dr_var matches 128..129 run function derailed:dev/idmap/branch/_nbbabba
execute if score #idmap_id dr_var matches 130..131 run function derailed:dev/idmap/branch/_nbbabbb
