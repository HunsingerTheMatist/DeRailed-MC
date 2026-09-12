# A mined stage block left its marker seed. Run as the seed, at the seed
#
# Each stage's loot table drops a seed carrying the resource block it belongs to
#  and the stage it came from, since nothing reports a broken block to a
#  datapack directly. The seed is a signal rather than loot, so it is read and
#  destroyed

execute store result score #mined_block dr_temp run \
    data get entity @s Item.components."minecraft:custom_data".dr_mined.block
execute store result score #mined_stage dr_temp run \
    data get entity @s Item.components."minecraft:custom_data".dr_mined.stage

kill @s

function derailed:generated/mined/dispatch
