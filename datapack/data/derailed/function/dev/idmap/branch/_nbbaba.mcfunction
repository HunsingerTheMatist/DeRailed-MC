# Narrows the region id to 123..127

execute if score #idmap_id dr_var matches 123..125 run function derailed:dev/idmap/branch/_nbbabaa
execute if score #idmap_id dr_var matches 126..127 run function derailed:dev/idmap/branch/_nbbabab
