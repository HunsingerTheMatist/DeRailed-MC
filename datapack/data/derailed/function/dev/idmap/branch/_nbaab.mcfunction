# Narrows the region id to 85..93

execute if score #idmap_id dr_var matches 85..89 run function derailed:dev/idmap/branch/_nbaaba
execute if score #idmap_id dr_var matches 90..93 run function derailed:dev/idmap/branch/_nbaabb
