# Narrows the region id to 118..120

execute if score #idmap_id dr_var matches 118..119 run function derailed:dev/idmap/branch/_nbbaabaa
execute if score #idmap_id dr_var matches 120..120 run function derailed:dev/idmap/branch/_nbbaabab
