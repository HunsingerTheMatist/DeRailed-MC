
scoreboard players operation #item dr_temp = @s dr_item
scoreboard players operation #pid dr_temp = @s dr_player_id
tag @e[type=interaction,distance=..10,tag=dr_placement] remove dr_current

# Touching any of three boxes a block tall from 3 pixels over the feet, 3 by 1.5
#  blocks, 1.5 by 3 and 2.5 by 2.5, which together round off the corners; the
#  box a selector tests is a block bigger each way than its dx, dy and dz, and
#  the pile stood on stays under them
# A placement held for this player is passed over
execute positioned ~-1.5 ~0.1875 ~-0.75 as @e[type=interaction,tag=dr_placement,dx=2,dy=0,dz=0.5] \
    if score @s dr_item = #item dr_temp unless score @s dr_player_id = #pid dr_temp run return run tag @s add dr_current
execute positioned ~-0.75 ~0.1875 ~-1.5 as @e[type=interaction,tag=dr_placement,dx=0.5,dy=0,dz=2] \
    if score @s dr_item = #item dr_temp unless score @s dr_player_id = #pid dr_temp run return run tag @s add dr_current
execute positioned ~-1.25 ~0.1875 ~-1.25 as @e[type=interaction,tag=dr_placement,dx=1.5,dy=0,dz=1.5] \
    if score @s dr_item = #item dr_temp unless score @s dr_player_id = #pid dr_temp run return run tag @s add dr_current
