
# Places the block for the region held in '#gen_id', for regions 24 and 25 and
#  the regions carried over the seam

execute if score #gen_id dr_var matches 24 run return run setblock ~ ~ ~ red_concrete strict
execute if score #gen_id dr_var matches 25 run return run setblock ~ ~ ~ white_wool strict

# The tiles the carried regions take are counted by kind, so that the section
#  can draw that much less of it for itself
execute if score #gen_id dr_var matches 26 run scoreboard players add #bleed_ground dr_var 1
execute if score #gen_id dr_var matches 27 run scoreboard players add #bleed_wood dr_var 1
execute if score #gen_id dr_var matches 28 run scoreboard players add #bleed_iron dr_var 1
execute if score #gen_id dr_var matches 29 run scoreboard players add #bleed_water dr_var 1
execute if score #gen_id dr_var matches 30 run scoreboard players add #bleed_rock dr_var 1
execute if score #gen_id dr_var matches 26 run return run setblock ~ ~ ~ lime_concrete strict
execute if score #gen_id dr_var matches 27 run return run setblock ~ ~ ~ brown_concrete strict
execute if score #gen_id dr_var matches 28 run return run setblock ~ ~ ~ light_gray_concrete strict
execute if score #gen_id dr_var matches 29 run return run setblock ~ ~ ~ blue_concrete strict
execute if score #gen_id dr_var matches 30 run return run setblock ~ ~ ~ gray_concrete strict
