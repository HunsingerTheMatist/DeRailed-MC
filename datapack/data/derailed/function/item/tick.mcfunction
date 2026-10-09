# Item system - runs every tick, in derailed:game

# A broken block of a tile drops a seed. This runs before the drop handler
#  below, which would otherwise see a seed with no thrower and leave it lying
#  in the world
execute as @e[type=item,tag=!dr_processed] at @s \
    if data entity @s Item.components."minecraft:custom_data".dr_mined \
    run function derailed:item/event/block_mined

# Processed items dropped with Q or Ctrl+Q
# 'at @s' matters: the handler looks for the thrower by distance, and without
#  it that distance is measured from wherever the tick runs, not the item
execute as @e[type=item,tag=!dr_processed] at @s run function derailed:item/event/item_dropped with entity @s

# Placing an item uses its spawn egg too, so what is left of 'dr_tool_used' is
#  cleared for the next tick's broken blocks
scoreboard players set @a[scores={dr_tool_used=1..}] dr_tool_used 0
