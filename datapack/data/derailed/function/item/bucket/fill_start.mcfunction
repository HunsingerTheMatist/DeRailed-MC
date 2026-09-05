
execute if score #bucket_is_filled dr_var matches 1 run return 1
execute if score #bucket_watchdog dr_arg matches ..0 run scoreboard players set #bucket_timer dr_arg 0
scoreboard players set #bucket_watchdog dr_arg 8
advancement revoke @s only derailed:bucket_tick

tellraw @a [{score:{name:"#bucket_timer",objective:"dr_arg"}}]
