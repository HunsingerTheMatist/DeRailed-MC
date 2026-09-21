# Narrows the region id to 123..124

execute if score #idmap_id dr_var matches 123..123 run function derailed:dev/idmap/branch/_nbbabaaaa
execute if score #idmap_id dr_var matches 124..124 run function derailed:dev/idmap/branch/_nbbabaaab
