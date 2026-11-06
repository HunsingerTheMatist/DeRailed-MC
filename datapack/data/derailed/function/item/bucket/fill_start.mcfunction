# Starts or keeps up this player filling their empty bucket at the water they
#  click: each click, which holding the button repeats every 4 ticks, keeps the
#  fill going 8 ticks more, and 'item/bucket/fill_tick' counts it up to
#  '$BucketFillTicks'
# Run as the player

execute if score @s dr_item = $BucketFull dr_const run return 1
execute unless score @s dr_fill_wait matches 1.. run scoreboard players set @s dr_fill_time 0
scoreboard players set @s dr_fill_wait 8
advancement revoke @s only derailed:bucket_tick
