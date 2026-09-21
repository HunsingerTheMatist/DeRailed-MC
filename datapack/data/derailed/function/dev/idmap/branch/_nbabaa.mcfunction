# Narrows the region id to 94..98

execute if score #idmap_id dr_var matches 94..96 run function derailed:dev/idmap/branch/_nbabaaa
execute if score #idmap_id dr_var matches 97..98 run function derailed:dev/idmap/branch/_nbabaab
