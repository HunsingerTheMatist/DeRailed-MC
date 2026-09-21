# Narrows the region id to 75..77

execute if score #idmap_id dr_var matches 75..76 run function derailed:dev/idmap/branch/_nbaaaaaa
execute if score #idmap_id dr_var matches 77..77 run function derailed:dev/idmap/branch/_nbaaaaab
