# Narrows the region id to 83..84

execute if score #idmap_id dr_var matches 83..83 run function derailed:dev/idmap/branch/_nbaaabba
execute if score #idmap_id dr_var matches 84..84 run function derailed:dev/idmap/branch/_nbaaabbb
