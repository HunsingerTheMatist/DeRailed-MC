# Empties the full bucket in this player's hand
# Run as the player

scoreboard players operation @s dr_item = $Bucket dr_const
function derailed:player/fix_items
playsound item.bucket.empty block @s
