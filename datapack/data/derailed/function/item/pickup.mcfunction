
scoreboard players operation #curr_resource dr_arg = @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] dr_resource

scoreboard players operation #give_count dr_arg = @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] dr_count
scoreboard players operation #pickup_cap dr_temp = $HandCap dr_config
scoreboard players operation #pickup_cap dr_temp -= @s dr_count
scoreboard players operation #give_count dr_arg < #pickup_cap dr_temp

# Sneaking narrows the action to a single resource
execute if predicate derailed:is_sneaking if score #give_count dr_arg matches 2.. run scoreboard players set #give_count dr_arg 1

scoreboard players operation @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] dr_count -= #give_count dr_arg

function derailed:item/give_resource
execute as @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] at @s run function derailed:resource/update_resource
