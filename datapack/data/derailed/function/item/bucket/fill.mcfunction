
# Validate the inventory to ensure bucket is in main hand
function derailed:player/check_inventory

item modify entity @s weapon.mainhand [{function:set_components,components:{custom_model_data:{strings:["filled"]}}}]
scoreboard players set #bucket_is_filled dr_var 1
