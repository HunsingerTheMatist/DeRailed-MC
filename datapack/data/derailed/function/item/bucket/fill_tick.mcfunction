# Counts this player's bucket a tick nearer full while they keep clicking the
#  water, and fills it once it has been '$BucketFillTicks'; letting go for
#  longer than the clicks repeat starts it over
# Run as the player, every tick while they fill

# The fill stops once no click has kept it going for 8 ticks
scoreboard players remove @s dr_fill_wait 1
execute if score @s dr_fill_wait matches ..0 run return run scoreboard players set @s dr_fill_time 0

# Near the end of that the count holds, waiting on the next click
execute if score @s dr_fill_wait matches ..2 run return run advancement revoke @s only derailed:bucket_tick

scoreboard players add @s dr_fill_time 1
execute if score @s dr_fill_time < $BucketFillTicks dr_config run return run advancement revoke @s only derailed:bucket_tick

function derailed:item/bucket/fill
scoreboard players reset @s dr_fill_wait
scoreboard players reset @s dr_fill_time
