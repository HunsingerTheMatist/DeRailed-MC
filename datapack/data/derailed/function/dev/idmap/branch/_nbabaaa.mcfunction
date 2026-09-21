# Narrows the region id to 94..96

execute if score #idmap_id dr_var matches 94..95 run function derailed:dev/idmap/branch/_nbabaaaa
execute if score #idmap_id dr_var matches 96..96 run function derailed:dev/idmap/branch/_nbabaaab
