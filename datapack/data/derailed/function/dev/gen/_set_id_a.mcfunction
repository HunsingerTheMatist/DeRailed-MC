
# Places the block for the region held in '#gen_id', for regions 0 to 7

execute if score #gen_id dr_var matches 0 run return run setblock ~ ~ ~ white_terracotta strict
execute if score #gen_id dr_var matches 1 run return run setblock ~ ~ ~ orange_terracotta strict
execute if score #gen_id dr_var matches 2 run return run setblock ~ ~ ~ magenta_terracotta strict
execute if score #gen_id dr_var matches 3 run return run setblock ~ ~ ~ light_blue_terracotta strict
execute if score #gen_id dr_var matches 4 run return run setblock ~ ~ ~ yellow_terracotta strict
execute if score #gen_id dr_var matches 5 run return run setblock ~ ~ ~ lime_terracotta strict
execute if score #gen_id dr_var matches 6 run return run setblock ~ ~ ~ pink_terracotta strict
execute if score #gen_id dr_var matches 7 run return run setblock ~ ~ ~ gray_terracotta strict
