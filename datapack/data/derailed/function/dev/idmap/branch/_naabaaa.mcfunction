# Narrows the region id to 19..21

execute if score #idmap_id dr_var matches 19..20 run function derailed:dev/idmap/branch/_naabaaaa
execute if score #idmap_id dr_var matches 21..21 run function derailed:dev/idmap/branch/_naabaaab
