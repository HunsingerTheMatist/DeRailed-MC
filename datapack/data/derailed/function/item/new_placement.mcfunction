
execute if score #curr_item dr_arg <= $LastResource dr_const run \
    return run function derailed:item/_new_resource_placement
execute if score #curr_item dr_arg >= $FirstTool dr_const if score #curr_item dr_arg <= $LastTool dr_const run \
    return run function derailed:item/_new_tool_placement
execute if score #curr_item dr_arg = $Bucket dr_const run \
    return run function derailed:item/_new_bucket_placement

#TODO: Make this error more descriptive
tellraw @a "Error!"
