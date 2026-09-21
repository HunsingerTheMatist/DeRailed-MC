# Narrows the region id to 19..28

execute if score #idmap_id dr_var matches 19..23 run function derailed:dev/idmap/branch/_naabaa
execute if score #idmap_id dr_var matches 24..28 run function derailed:dev/idmap/branch/_naabab
