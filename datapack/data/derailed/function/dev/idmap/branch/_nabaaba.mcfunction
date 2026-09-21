# Narrows the region id to 43..45

execute if score #idmap_id dr_var matches 43..44 run function derailed:dev/idmap/branch/_nabaabaa
execute if score #idmap_id dr_var matches 45..45 run function derailed:dev/idmap/branch/_nabaabab
