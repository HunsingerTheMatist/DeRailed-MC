# Puts the items where the player clicked, as 'item/try_place_clicked' says
# The floor is this block where it is a bottom slab or stairs, which a spawn
#  egg's marker can land in, and otherwise the block under this one, with this
#  one free to place in
# Run as the player, at the bottom middle of the clicked block
#
# Returns 1 when any items were placed, fail otherwise

execute positioned ~-0.5 ~-1 ~-0.5 at @n[type=interaction,tag=dr_placement,dx=0,dy=1,dz=0] if score @n[type=interaction,tag=dr_placement,distance=..0.01] dr_item = #curr_item dr_arg run \
    return run function derailed:item/place_existing
execute positioned ~-0.5 ~-1 ~-0.5 if entity @n[type=interaction,tag=dr_placement,dx=0,dy=1,dz=0] run return fail

execute if block ~ ~ ~ #minecraft:slabs[type=bottom] if block ~ ~ ~ #derailed:pile_floor run \
    return run function derailed:item/place_on_floor
execute if block ~ ~ ~ #minecraft:stairs[half=bottom] if block ~ ~ ~ #derailed:pile_floor run \
    return run function derailed:item/place_on_floor
execute unless block ~ ~ ~ #derailed:valid_placements run return fail
execute positioned ~ ~-1 ~ if block ~ ~ ~ #derailed:pile_floor run \
    return run function derailed:item/place_on_floor
return fail
