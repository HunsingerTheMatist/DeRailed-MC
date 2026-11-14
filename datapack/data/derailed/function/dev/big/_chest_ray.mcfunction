
# Steps the ray a quarter of a block on toward the player's eyes, and marks the
#  chest seen, '#ch_seen' 1, once it reaches them; it stops wherever it cannot
#  pass ('_chest_clear')
# Positioned on the ray, facing the player's eyes

scoreboard players add #ch_rs dr_temp 1
execute if score #ch_rs dr_temp matches 120.. run return 0
execute if entity @n[type=marker,tag=dr_chest_walker,distance=..0.3] run return run scoreboard players set #ch_seen dr_temp 1
execute unless function derailed:dev/big/_chest_clear run return 0
execute positioned ^ ^ ^0.25 run function derailed:dev/big/_chest_ray
