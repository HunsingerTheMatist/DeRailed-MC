# Narrows the region id to 10..18

execute if score #idmap_id dr_var matches 10..14 run function derailed:dev/idmap/branch/_naaaba
execute if score #idmap_id dr_var matches 15..18 run function derailed:dev/idmap/branch/_naaabb
