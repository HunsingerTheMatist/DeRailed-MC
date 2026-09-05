
# If the watchdog has timed out the bucket fill timer is reset
scoreboard players remove #bucket_watchdog dr_arg 1
execute if score #bucket_watchdog dr_arg matches ..0 run \
    return run scoreboard players set #bucket_timer dr_arg 0

# If the watchdog has almost timed out do nothing to the bucket fill timer
execute if score #bucket_watchdog dr_arg matches ..2 run \
    return run advancement revoke @s only derailed:bucket_tick

scoreboard players add #bucket_timer dr_arg 1
execute if score #bucket_timer dr_arg < $BucketFillTicks dr_config run \
    return run advancement revoke @s only derailed:bucket_tick

function derailed:item/bucket/fill
scoreboard players reset #bucket_watchdog dr_arg
scoreboard players reset #bucket_timer dr_arg
