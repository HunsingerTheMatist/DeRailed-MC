# Narrows the region id to 94..103

execute if score #idmap_id dr_var matches 94..98 run function derailed:dev/idmap/branch/_nbabaa
execute if score #idmap_id dr_var matches 99..103 run function derailed:dev/idmap/branch/_nbabab
