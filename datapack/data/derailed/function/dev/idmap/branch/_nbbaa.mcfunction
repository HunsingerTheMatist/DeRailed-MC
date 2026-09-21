# Narrows the region id to 113..122

execute if score #idmap_id dr_var matches 113..117 run function derailed:dev/idmap/branch/_nbbaaa
execute if score #idmap_id dr_var matches 118..122 run function derailed:dev/idmap/branch/_nbbaab
