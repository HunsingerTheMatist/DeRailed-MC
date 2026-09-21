# Narrows the region id to 80..84

execute if score #idmap_id dr_var matches 80..82 run function derailed:dev/idmap/branch/_nbaaaba
execute if score #idmap_id dr_var matches 83..84 run function derailed:dev/idmap/branch/_nbaaabb
