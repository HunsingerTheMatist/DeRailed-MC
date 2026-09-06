# Summon one item display for #curr_resource at this position
# Run as the pile's interaction entity
#
# Args:
# #curr_resource - the pile's resource type

execute if score #curr_resource dr_arg = $Wood dr_const run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"oak_log",    components: {item_model:"derailed:wood"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[0.8,0.8,0.8], translation:[0,-0.125,0]}, Tags:["dr_resource"]}
execute if score #curr_resource dr_arg = $Iron dr_const run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"iron_block", components: {item_model:"derailed:iron"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[0.9,0.9,0.9], translation:[0,-0.05,0]}, Tags:["dr_resource"]}
execute if score #curr_resource dr_arg = $Rail dr_const run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"rail",       components: {item_model:"derailed:rail"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[1,1,1], translation:[0,0,0]}, Tags:["dr_resource"]}
#execute if score #curr_resource dr_arg = $Bucket dr_const if score #bucket_is_filled dr_var matches 0 run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"bucket",     components: {item_model:"derailed:bucket"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[0.8,0.8,0.8], translation:[0,-0.1,0]}, Tags:["dr_resource"]}
#execute if score #curr_resource dr_arg = $Bucket dr_const if score #bucket_is_filled dr_var matches 1 run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"bucket",     components: {item_model:"derailed:bucket", custom_model_data:{strings:["filled"]}}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[0.8,0.8,0.8], translation:[0,-0.1,0]}, Tags:["dr_resource"]}

execute if score #curr_resource dr_arg = $Bucket dr_const run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"bucket",     components: {item_model:"derailed:bucket"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[0.8,0.8,0.8], translation:[0,-0.1,0]}, Tags:["dr_resource"]}

execute if score #curr_resource dr_arg = $Bucket dr_const if score #bucket_is_filled dr_var matches 1 run item modify entity @n[type=item_display,distance=..0.1,tag=dr_resource] container.0 [{function:"set_components",components:{custom_model_data:{strings:["filled"]}}}]

execute if score #curr_resource dr_arg matches 10 run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"oak_log",    components: {item_model:"derailed:_small_wood"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[1,1,1], translation:[0,0,0]}, Tags:["dr_resource"]}
execute if score #curr_resource dr_arg matches 11 run \
    summon minecraft:item_display ~ ~ ~ {item: {id:"iron_block", components: {item_model:"derailed:_small_iron"}}, transformation: {left_rotation:[0,0,0,1], right_rotation:[0,0,0,1], scale:[1,1,1], translation:[0,0,0]}, Tags:["dr_resource"]}

execute store result score #rotation dr_temp run data get entity @s Rotation[0]
execute store result entity @n[type=item_display,distance=..0.1,tag=dr_resource] Rotation[0] float 1 run scoreboard players get #rotation dr_temp

# Faces along z catch more light than faces along x, and the models are built
#  with their ends along z, so a display standing straight renders those ends
#  brighter. The model tints them back down
scoreboard players operation #use_darker_tint dr_temp = #rotation dr_temp
scoreboard players operation #use_darker_tint dr_temp %= $HalfTurn dr_const
execute if score #curr_resource dr_arg = $Wood dr_const if score #use_darker_tint dr_temp matches 0 run \
    data modify entity @n[type=item_display,distance=..0.1,tag=dr_resource] item.components."minecraft:custom_model_data" set value {strings:["turned"]}
