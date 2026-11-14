
# Changes the rock beside this top block the way 'chest.edit' says, '_chest_eval'
#  having found every change it asks for can be made: a side to be a full block
#  becomes bedrock, one to be a slab a rock slab, one to be air air, each where
#  it is not already, one to be a slab or air a rock slab where it is bedrock,
#  and one to be a slab or a full block a rock slab where it is air, those
#  being the fewer changes
# Positioned at the chest's top block

execute if data storage derailed:big chest.edit{n:"f"} unless block ~ ~ ~-1 bedrock run setblock ~ ~ ~-1 bedrock strict
execute if data storage derailed:big chest.edit{e:"f"} unless block ~1 ~ ~ bedrock run setblock ~1 ~ ~ bedrock strict
execute if data storage derailed:big chest.edit{s:"f"} unless block ~ ~ ~1 bedrock run setblock ~ ~ ~1 bedrock strict
execute if data storage derailed:big chest.edit{w:"f"} unless block ~-1 ~ ~ bedrock run setblock ~-1 ~ ~ bedrock strict
execute if data storage derailed:big chest.edit{n:"s"} unless block ~ ~ ~-1 cobbled_deepslate_slab run setblock ~ ~ ~-1 cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{e:"s"} unless block ~1 ~ ~ cobbled_deepslate_slab run setblock ~1 ~ ~ cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{s:"s"} unless block ~ ~ ~1 cobbled_deepslate_slab run setblock ~ ~ ~1 cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{w:"s"} unless block ~-1 ~ ~ cobbled_deepslate_slab run setblock ~-1 ~ ~ cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{n:"a"} unless block ~ ~ ~-1 air run setblock ~ ~ ~-1 air strict
execute if data storage derailed:big chest.edit{e:"a"} unless block ~1 ~ ~ air run setblock ~1 ~ ~ air strict
execute if data storage derailed:big chest.edit{s:"a"} unless block ~ ~ ~1 air run setblock ~ ~ ~1 air strict
execute if data storage derailed:big chest.edit{w:"a"} unless block ~-1 ~ ~ air run setblock ~-1 ~ ~ air strict
execute if data storage derailed:big chest.edit{n:"o"} if block ~ ~ ~-1 bedrock run setblock ~ ~ ~-1 cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{e:"o"} if block ~1 ~ ~ bedrock run setblock ~1 ~ ~ cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{s:"o"} if block ~ ~ ~1 bedrock run setblock ~ ~ ~1 cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{w:"o"} if block ~-1 ~ ~ bedrock run setblock ~-1 ~ ~ cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{n:"r"} if block ~ ~ ~-1 air run setblock ~ ~ ~-1 cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{e:"r"} if block ~1 ~ ~ air run setblock ~1 ~ ~ cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{s:"r"} if block ~ ~ ~1 air run setblock ~ ~ ~1 cobbled_deepslate_slab[type=bottom] strict
execute if data storage derailed:big chest.edit{w:"r"} if block ~-1 ~ ~ air run setblock ~-1 ~ ~ cobbled_deepslate_slab[type=bottom] strict
