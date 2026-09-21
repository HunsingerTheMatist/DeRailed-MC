# Narrows the region id to 97..98

execute if score #idmap_id dr_var matches 97..97 run function derailed:dev/idmap/branch/_nbabaaba
execute if score #idmap_id dr_var matches 98..98 run function derailed:dev/idmap/branch/_nbabaabb
