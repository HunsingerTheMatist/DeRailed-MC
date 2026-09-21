# Narrows the region id to 29..31

execute if score #idmap_id dr_var matches 29..30 run function derailed:dev/idmap/branch/_naabbaaa
execute if score #idmap_id dr_var matches 31..31 run function derailed:dev/idmap/branch/_naabbaab
