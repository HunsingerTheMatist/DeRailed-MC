# Fills the empty bucket in this player's hand with water
# Run as the player

execute unless score @s dr_item = $Bucket dr_const run return fail
scoreboard players operation @s dr_item = $BucketFull dr_const
function derailed:player/fix_items
playsound item.bucket.fill block @s
