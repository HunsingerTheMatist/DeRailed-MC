# Narrows the region id to 85..89

execute if score #idmap_id dr_var matches 85..87 run function derailed:dev/idmap/branch/_nbaabaa
execute if score #idmap_id dr_var matches 88..89 run function derailed:dev/idmap/branch/_nbaabab
