
#say Water
data remove entity @n[type=interaction,distance=..1,tag=dr_water,tag=dr_current] interaction

execute if score #curr_item dr_arg = $Bucket dr_const run \
    return run function derailed:item/bucket/fill_start

scoreboard players set #curr_item_count dr_arg 1

# TODO: Places scaffolding bridge if connected
execute if score #curr_item dr_arg = $Wood dr_const run \
    return run function derailed:item/bridge/try_place_wood
