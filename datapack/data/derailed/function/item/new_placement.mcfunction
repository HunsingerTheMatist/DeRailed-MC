
execute if score #curr_item dr_arg <= $LastResource dr_const run \
    return run summon interaction ~ ~ ~ {width:0.885, height:0.01, Tags:["dr_placement"]}
execute if score #curr_item dr_arg >= $FirstTool dr_const if score #curr_item dr_arg <= $LastTool dr_const run \
    return run summon interaction ~ ~ ~ {width:0.876, height:0.064, Tags:["dr_placement"]}
execute if score #curr_item dr_arg = $Bucket dr_const run \
    return run summon interaction ~ ~ ~ {width:1.002, height:1.002, Tags:["dr_placement"]}

#TODO: Make this error more descriptive
tellraw @a "Error!"
