# A mined stage block left its marker seed. Run as the seed, at the seed
#
# Each stage's loot table drops a seed carrying the item and the stage it came
#  from, since nothing reports a broken block to a datapack directly. The seed
#  is a signal rather than loot, so it is read and destroyed
#
# Block drops appear within the block they came from, so aligning recovers the
#  tile without having to guess

execute store result score #mined_item dr_temp run \
    data get entity @s Item.components."minecraft:custom_data".dr_mined.item
execute store result score #mined_stage dr_temp run \
    data get entity @s Item.components."minecraft:custom_data".dr_mined.stage

kill @s

#execute if score #mined_item dr_temp = $Wood dr_const if score #mined_stage dr_temp matches 1 run \
    return run setblock ~ ~ ~ acacia_fence strict
#execute if score #mined_item dr_temp = $Wood dr_const if score #mined_stage dr_temp matches 2 run \
    return run setblock ~ ~ ~ oxidized_lightning_rod strict

#execute if score #mined_item dr_temp = $Wood dr_const if score #mined_stage dr_temp matches 1 run \
    return run setblock ~ ~ ~ oak_leaves[persistent=false] strict
#execute if score #mined_item dr_temp = $Wood dr_const if score #mined_stage dr_temp matches 2 run \
    return run setblock ~ ~ ~ green_stained_glass strict

#execute if score #mined_item dr_temp matches 4 if score #mined_stage dr_temp matches 1 run \
    return run setblock ~ ~ ~ oak_leaves[persistent=false] strict
execute if score #mined_item dr_temp matches 4 if score #mined_stage dr_temp matches 1 run \
    return run setblock ~ ~ ~ red_stained_glass strict
execute if score #mined_item dr_temp matches 4 if score #mined_stage dr_temp matches 2 run \
    return run setblock ~ ~ ~ green_stained_glass strict

scoreboard players set #curr_item_count dr_arg 1
scoreboard players operation #curr_item dr_arg = #mined_item dr_temp
scoreboard players set #curr_rotation dr_arg 0

execute if score #mined_item dr_temp <= $LastResource dr_const if score #mined_stage dr_temp matches 3 \
    align xyz positioned ~0.5 ~ ~0.5 run \
    return run function derailed:item/place_new

#execute if score #mined_item dr_temp = $Wood dr_const if score #mined_stage dr_temp matches 3 run \
    scoreboard players operation #curr_item dr_arg
