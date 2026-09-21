# Narrows the region id to 15..16

execute if score #idmap_id dr_var matches 15..15 run function derailed:dev/idmap/branch/_naaabbaa
execute if score #idmap_id dr_var matches 16..16 run function derailed:dev/idmap/branch/_naaabbab
