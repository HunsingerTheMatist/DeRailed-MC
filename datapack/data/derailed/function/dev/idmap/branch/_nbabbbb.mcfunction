# Narrows the region id to 111..112

execute if score #idmap_id dr_var matches 111..111 run function derailed:dev/idmap/branch/_nbabbbba
execute if score #idmap_id dr_var matches 112..112 run function derailed:dev/idmap/branch/_nbabbbbb
