# Narrows the region id to 99..103

execute if score #idmap_id dr_var matches 99..101 run function derailed:dev/idmap/branch/_nbababa
execute if score #idmap_id dr_var matches 102..103 run function derailed:dev/idmap/branch/_nbababb
