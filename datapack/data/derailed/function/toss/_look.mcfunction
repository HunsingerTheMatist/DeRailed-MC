# Gives this thrown display the look of #curr_item_count of #curr_item, as a
#  placement's display draws them, lifted half a block since this display
#  stands at the bottom of its box rather than half a block up it
# Run as the display

execute if score #curr_item dr_arg = $Wood dr_const run \
    data merge entity @s {item:{id:"oak_log",components:{item_model:"derailed:wood"}},transformation:{left_rotation:[0,0,0,1],right_rotation:[0,0,0,1],scale:[1,1,1],translation:[0,0.5,0]}}
execute if score #curr_item dr_arg = $Iron dr_const run \
    data merge entity @s {item:{id:"iron_block",components:{item_model:"derailed:iron"}},transformation:{left_rotation:[0,0,0,1],right_rotation:[0,0,0,1],scale:[2,2,2],translation:[0,1,0]}}
execute if score #curr_item dr_arg = $Rail dr_const run \
    data merge entity @s {item:{id:"rail",components:{item_model:"derailed:rail"}},transformation:{left_rotation:[0,0,0,1],right_rotation:[0,0,0,1],scale:[2,2,2],translation:[0,1,0]}}
execute if score #curr_item dr_arg = $Bucket dr_const run \
    data merge entity @s {item:{id:"bucket",components:{item_model:"derailed:bucket"}},transformation:{left_rotation:[0,0,0,1],right_rotation:[0,0,0,1],scale:[1.6,1.6,1.6],translation:[0,0.8,0]}}
execute if score #curr_item dr_arg = $Bucket dr_const if score #bucket_is_filled dr_var matches 1 run \
    item modify entity @s container.0 [{type:"set_components",components:{custom_model_data:{strings:["filled"]}}}]
execute if score #curr_item dr_arg = $Axe dr_const run \
    data merge entity @s {item:{id:"stone_axe"},transformation:{left_rotation:[1,0,0,1],right_rotation:[0,0,0,1],scale:[1,1,1],translation:[0,0.03125,0]}}
execute if score #curr_item dr_arg = $Pickaxe dr_const run \
    data merge entity @s {item:{id:"stone_pickaxe"},transformation:{left_rotation:[1,0,0,1],right_rotation:[0,0,0,1],scale:[1,1,1],translation:[0,0.03125,0]}}
execute store result entity @s item.count int 1 run scoreboard players get #curr_item_count dr_arg
