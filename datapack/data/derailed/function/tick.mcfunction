# Runs every tick

# If a player has no id, assign one
execute as @a unless score @s dr_player_id matches 1.. run function derailed:player/init

# If the game dimension is missing, stop here
# The dimension only registers at world load, so this clears once the world is
#  reopened
scoreboard players set #dimension_ok dr_var 0
execute in derailed:game run scoreboard players set #dimension_ok dr_var 1
execute if score #dimension_ok dr_var matches 0 run return fail

#execute as @a run function derailed:player/dash_tick

execute in derailed:game run function derailed:item/tick

# If two ticks have passed, check every player inventory
# This MUST run after the item tick: a dropped item leaves the inventory before
#  'item_dropped' amends the record, and a check landing in that gap would see a
#  short hand and mint the dropped item straight back
scoreboard players add #inv_check dr_var 1
execute if score #inv_check dr_var matches 2.. as @a run function derailed:player/check_inventory
execute if score #inv_check dr_var matches 2.. run scoreboard players set #inv_check dr_var 0
