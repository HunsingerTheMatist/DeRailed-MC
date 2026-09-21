# Narrows the region id to 99..101

execute if score #idmap_id dr_var matches 99..100 run function derailed:dev/idmap/branch/_nbababaa
execute if score #idmap_id dr_var matches 101..101 run function derailed:dev/idmap/branch/_nbababab
