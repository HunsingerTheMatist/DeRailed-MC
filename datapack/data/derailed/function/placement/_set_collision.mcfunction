# Sets what players bump into for this placement, a pixel short of the top of a
#  pile and at the top of a block for the bucket: cakes, drawn as nothing, in
#  every block whose cake comes no higher than that, and one invisible shulker
#  as wide as a cake making up the rest, riding an interaction a block under the
#  block the placement stands in; and clears the blocks in 'pile_replaceable'
#  out of its way
# The cakes fill only the bottom half of each block, which leaves gaps far too
#  small for a player
# Run as the placement's interaction entity, at it

execute align y run function derailed:placement/_clear_collision
execute positioned ~-0.5 ~-2 ~-0.5 as @e[type=interaction,tag=dr_pile_lift,dx=0,dy=2,dz=0] on passengers run function derailed:placement/_remove_box
execute positioned ~-0.5 ~-2 ~-0.5 run kill @e[type=interaction,tag=dr_pile_lift,dx=0,dy=2,dz=0]
execute if score @s dr_count matches ..0 run return 0

# How high the placement is drawn, in ten-thousandths of a block
scoreboard players set #pile_height dr_temp 0
execute if score @s dr_item <= $LastResource dr_const run scoreboard players operation #pile_height dr_temp = $ScaledLayer dr_const
execute if score @s dr_item = $Wood dr_const run scoreboard players operation #pile_height dr_temp = $WoodLayer dr_const
execute if score @s dr_item <= $LastResource dr_const run scoreboard players operation #pile_height dr_temp *= @s dr_count
execute if score @s dr_item = $Bucket dr_const run scoreboard players set #pile_height dr_temp 10000

# How high up the block it stands in it reaches
execute store result score #base_rel dr_temp run data get entity @s Pos[1] 10000
scoreboard players operation #base_rel dr_temp %= $TenThousand dr_const
scoreboard players operation #top dr_temp = #base_rel dr_temp
scoreboard players operation #top dr_temp += #pile_height dr_temp
scoreboard players operation #clear_left dr_temp = #top dr_temp
execute align y run function derailed:placement/_clear_foliage

execute if score @s dr_item >= $FirstTool dr_const if score @s dr_item <= $LastTool dr_const run return 0
execute if score @s dr_item <= $LastResource dr_const run scoreboard players remove #top dr_temp 625

# Cakes from the block it stands in, or from the one above where that holds
#  the slab it stands on, in each block whose cake's top, half way up it, is
#  no higher than the top
scoreboard players set #cake_from dr_temp 0
execute unless block ~ ~ ~ #derailed:valid_placements run scoreboard players set #cake_from dr_temp 1
scoreboard players operation #cake_to dr_temp = #top dr_temp
scoreboard players add #cake_to dr_temp 5000
scoreboard players operation #cake_to dr_temp /= $TenThousand dr_const
scoreboard players set #cake_at dr_temp 0
execute align y run function derailed:placement/_add_cakes

# The shulker's top is the top of what players bump into, where the cakes
#  fall short of it
scoreboard players operation #rem dr_temp = #top dr_temp
scoreboard players add #rem dr_temp 5000
scoreboard players operation #rem dr_temp %= $TenThousand dr_const
execute if score #cake_to dr_temp > #cake_from dr_temp if score #rem dr_temp matches 0 run return 0
execute align y positioned ~ ~-1 ~ run summon interaction ~ ~ ~ {Tags:["dr_pile_lift","dr_pile_new"],width:0f,height:0f,Passengers:[{id:"minecraft:shulker",Tags:["dr_pile_box"],Invulnerable:true,NoAI:true,Silent:true,Health:1,DeathLootTable:"minecraft:empty",attributes:[{id:"minecraft:scale",base:0.875}],active_effects:[{id:"minecraft:invisibility",duration:-1,show_particles:false}]}]}

# It rides the top less its height of 0.875 up from the interaction, a block
#  under the block the placement stands in
scoreboard players add #top dr_temp 1250
execute store result entity @n[type=interaction,tag=dr_pile_new,distance=..2] height float 0.0001 run scoreboard players get #top dr_temp
tag @n[type=interaction,tag=dr_pile_new,distance=..2] remove dr_pile_new
