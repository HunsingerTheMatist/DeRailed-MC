# Narrows the region id to 80..82

execute if score #idmap_id dr_var matches 80..81 run function derailed:dev/idmap/branch/_nbaaabaa
execute if score #idmap_id dr_var matches 82..82 run function derailed:dev/idmap/branch/_nbaaabab
