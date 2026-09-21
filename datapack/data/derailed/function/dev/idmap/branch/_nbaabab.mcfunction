# Narrows the region id to 88..89

execute if score #idmap_id dr_var matches 88..88 run function derailed:dev/idmap/branch/_nbaababa
execute if score #idmap_id dr_var matches 89..89 run function derailed:dev/idmap/branch/_nbaababb
