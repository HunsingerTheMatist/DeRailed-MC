# Narrows the region id to 141..143

execute if score #idmap_id dr_var matches 141..142 run function derailed:dev/idmap/branch/_nbbbbaaa
execute if score #idmap_id dr_var matches 143..143 run function derailed:dev/idmap/branch/_nbbbbaab
