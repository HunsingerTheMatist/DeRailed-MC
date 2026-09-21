# Narrows the region id to 75..84

execute if score #idmap_id dr_var matches 75..79 run function derailed:dev/idmap/branch/_nbaaaa
execute if score #idmap_id dr_var matches 80..84 run function derailed:dev/idmap/branch/_nbaaab
