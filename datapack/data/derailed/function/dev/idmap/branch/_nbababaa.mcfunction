# Narrows the region id to 99..100

execute if score #idmap_id dr_var matches 99..99 run function derailed:dev/idmap/branch/_nbababaaa
execute if score #idmap_id dr_var matches 100..100 run function derailed:dev/idmap/branch/_nbababaab
