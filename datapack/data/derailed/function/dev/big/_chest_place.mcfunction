
# Puts a chest in place of this column's top block, facing the nearest side of
#  the mountain, block by block, north before south before east before west
#  where two are as near, with the slab over it gone and the rock beside it
#  changed to give it the sides its difficulty asks for ('_chest_eval')
# The block is a trapped chest, which the resource pack draws as nothing; an
#  item display draws the chest over it, a regular chest on easy and an ender
#  chest otherwise, with its lid shut until 'ender_chest/open', an interaction
#  a hundredth of a block bigger than it takes the clicks, and a marker tagged
#  'dr_chest_spark' in its middle has it sparkle ('tick') until it is opened
# Run as the column's marker, at its top block

execute if block ~ ~1 ~ cobbled_deepslate_slab run setblock ~ ~1 ~ air strict
function derailed:dev/big/_chest_eval
function derailed:dev/big/_chest_edits

scoreboard players set #ch_s dr_temp 0
function derailed:dev/big/_chest_side {x:0,z:-1}
scoreboard players operation #ch_dn dr_temp = #ch_s dr_temp
scoreboard players set #ch_s dr_temp 0
function derailed:dev/big/_chest_side {x:0,z:1}
scoreboard players operation #ch_ds dr_temp = #ch_s dr_temp
scoreboard players set #ch_s dr_temp 0
function derailed:dev/big/_chest_side {x:1,z:0}
scoreboard players operation #ch_de dr_temp = #ch_s dr_temp
scoreboard players set #ch_s dr_temp 0
function derailed:dev/big/_chest_side {x:-1,z:0}
scoreboard players operation #ch_dw dr_temp = #ch_s dr_temp
scoreboard players operation #ch_m dr_temp = #ch_dn dr_temp
scoreboard players operation #ch_m dr_temp < #ch_ds dr_temp
scoreboard players operation #ch_m dr_temp < #ch_de dr_temp
scoreboard players operation #ch_m dr_temp < #ch_dw dr_temp

# The way it faces, 0 north, 1 east, 2 south and 3 west, each taken over the
#  one after it in the order the ties go
scoreboard players set #ch_f dr_temp 3
execute if score #ch_de dr_temp = #ch_m dr_temp run scoreboard players set #ch_f dr_temp 1
execute if score #ch_ds dr_temp = #ch_m dr_temp run scoreboard players set #ch_f dr_temp 2
execute if score #ch_dn dr_temp = #ch_m dr_temp run scoreboard players set #ch_f dr_temp 0
execute if score #ch_f dr_temp matches 0 run setblock ~ ~ ~ trapped_chest[facing=north] strict
execute if score #ch_f dr_temp matches 1 run setblock ~ ~ ~ trapped_chest[facing=east] strict
execute if score #ch_f dr_temp matches 2 run setblock ~ ~ ~ trapped_chest[facing=south] strict
execute if score #ch_f dr_temp matches 3 run setblock ~ ~ ~ trapped_chest[facing=west] strict

# An item display turns its item a half turn, and a chest drawn as an item faces
#  south, so a turn of 0 faces it north, 90 east, 180 south and 270 west
execute if score $Difficulty dr_config matches ..0 run summon item_display ~0.5 ~0.5 ~0.5 {Tags:["dr_ender_chest_lid","dr_ender_chest_new"],item:{id:"minecraft:chest",count:1,components:{"minecraft:item_model":"derailed:chest","minecraft:custom_model_data":{floats:[0f]}}}}
execute if score $Difficulty dr_config matches 1.. run summon item_display ~0.5 ~0.5 ~0.5 {Tags:["dr_ender_chest_lid","dr_ender_chest_new"],item:{id:"minecraft:ender_chest",count:1,components:{"minecraft:item_model":"derailed:ender_chest","minecraft:custom_model_data":{floats:[0f]}}}}
execute store result entity @n[type=item_display,tag=dr_ender_chest_new,distance=..1] Rotation[0] float 90 run scoreboard players get #ch_f dr_temp
tag @e[type=item_display,tag=dr_ender_chest_new,distance=..1] remove dr_ender_chest_new
summon interaction ~0.5 ~ ~0.5 {Tags:["dr_ender_chest"],width:0.885f,height:0.885f}
summon marker ~0.5 ~0.5 ~0.5 {Tags:["dr_chest_spark"]}
return 1
