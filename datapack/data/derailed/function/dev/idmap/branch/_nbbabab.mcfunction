# Narrows the region id to 126..127

execute if score #idmap_id dr_var matches 126..126 run function derailed:dev/idmap/branch/_nbbababa
execute if score #idmap_id dr_var matches 127..127 run function derailed:dev/idmap/branch/_nbbababb
