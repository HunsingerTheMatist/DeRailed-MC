# Narrows the region id to 123..125

execute if score #idmap_id dr_var matches 123..124 run function derailed:dev/idmap/branch/_nbbabaaa
execute if score #idmap_id dr_var matches 125..125 run function derailed:dev/idmap/branch/_nbbabaab
