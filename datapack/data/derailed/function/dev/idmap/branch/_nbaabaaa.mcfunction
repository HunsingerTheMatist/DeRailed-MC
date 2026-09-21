# Narrows the region id to 85..86

execute if score #idmap_id dr_var matches 85..85 run function derailed:dev/idmap/branch/_nbaabaaaa
execute if score #idmap_id dr_var matches 86..86 run function derailed:dev/idmap/branch/_nbaabaaab
