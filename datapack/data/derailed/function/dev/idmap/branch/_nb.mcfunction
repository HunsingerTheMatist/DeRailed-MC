# Narrows the region id to 75..149

execute if score #idmap_id dr_var matches 75..112 run function derailed:dev/idmap/branch/_nba
execute if score #idmap_id dr_var matches 113..149 run function derailed:dev/idmap/branch/_nbb
