# Narrows the region id to 29..30

execute if score #idmap_id dr_var matches 29..29 run function derailed:dev/idmap/branch/_naabbaaaa
execute if score #idmap_id dr_var matches 30..30 run function derailed:dev/idmap/branch/_naabbaaab
