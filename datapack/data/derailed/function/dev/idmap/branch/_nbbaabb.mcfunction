# Narrows the region id to 121..122

execute if score #idmap_id dr_var matches 121..121 run function derailed:dev/idmap/branch/_nbbaabba
execute if score #idmap_id dr_var matches 122..122 run function derailed:dev/idmap/branch/_nbbaabbb
