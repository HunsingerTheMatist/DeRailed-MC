# Narrows the region id to 29..33

execute if score #idmap_id dr_var matches 29..31 run function derailed:dev/idmap/branch/_naabbaa
execute if score #idmap_id dr_var matches 32..33 run function derailed:dev/idmap/branch/_naabbab
