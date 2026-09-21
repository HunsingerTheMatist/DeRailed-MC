# Maps one section worth of tiles through 'macro', then starts the next pass

scoreboard players set #idmap_z dr_var 20
execute positioned 1000.0 0.0 0.0 run function derailed:dev/idmap/macro/_row

scoreboard players remove #idmap_pass dr_var 1
execute if score #idmap_pass dr_var matches 1.. run function derailed:dev/idmap/macro/_pass
