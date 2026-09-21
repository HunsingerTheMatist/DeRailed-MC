
# Places the block for the region held in '#gen_id', for regions 16 to 23

execute if score #gen_id dr_var matches 16 run return run setblock ~ ~ ~ white_concrete strict
execute if score #gen_id dr_var matches 17 run return run setblock ~ ~ ~ orange_concrete strict
execute if score #gen_id dr_var matches 18 run return run setblock ~ ~ ~ magenta_concrete strict
execute if score #gen_id dr_var matches 19 run return run setblock ~ ~ ~ yellow_concrete strict
execute if score #gen_id dr_var matches 20 run return run setblock ~ ~ ~ pink_concrete strict
execute if score #gen_id dr_var matches 21 run return run setblock ~ ~ ~ cyan_concrete strict
execute if score #gen_id dr_var matches 22 run return run setblock ~ ~ ~ purple_concrete strict
execute if score #gen_id dr_var matches 23 run return run setblock ~ ~ ~ green_concrete strict
