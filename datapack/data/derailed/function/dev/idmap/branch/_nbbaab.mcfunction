# Narrows the region id to 118..122

execute if score #idmap_id dr_var matches 118..120 run function derailed:dev/idmap/branch/_nbbaaba
execute if score #idmap_id dr_var matches 121..122 run function derailed:dev/idmap/branch/_nbbaabb
