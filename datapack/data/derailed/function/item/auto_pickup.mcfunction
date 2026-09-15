# Top up a partly full hand from a placement underfoot
# Run as the player, at the player

# Check if the player can take more items
execute unless score @s dr_item <= $LastResource dr_const run return fail
execute if score @s dr_count >= $HandCap dr_config run return fail

# If there is a valid resource pile nearby, tag it
function derailed:item/_auto_pickup

execute at @n[type=interaction,distance=..1,tag=dr_current] run function derailed:item/pickup
