# Narrows the region id to 17..18

execute if score #idmap_id dr_var matches 17..17 run function derailed:dev/idmap/branch/_naaabbba
execute if score #idmap_id dr_var matches 18..18 run function derailed:dev/idmap/branch/_naaabbbb
