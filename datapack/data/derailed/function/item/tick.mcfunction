# Item system - runs every tick, in derailed:game

# Processed items dropped with Q or Ctrl+Q
# 'at @s' matters: the handler looks for the thrower by distance, and without
#  it that distance is measured from wherever the tick runs, not the item
execute as @e[type=item,tag=!dr_processed] at @s run function derailed:item/event/item_dropped with entity @s
