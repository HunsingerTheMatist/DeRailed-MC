
# Fills in one run of cut rock, going by what stands at its two ends along the
#  route
# Water at both ends, river or lake either, runs through the whole cut as river.
#  A river at one end gives way to the land at the other, ground, wood or iron,
#  which then fills the whole cut. Any other run is filled from both ends at
#  once - first tile, then last, then second and last but one - each tile
#  becoming the nearest terrain other than rock or river, so that it takes the
#  terrain it opens onto at each end and the two meet in the middle
# Positioned at the section's corner

execute as @e[type=marker,tag=dr_cut_run,distance=0..] if score @s dr_step = #cut_r dr_var run function derailed:dev/gen/_cut_run_ends

scoreboard players set #cut_fill dr_var -1
execute if score #cut_a dr_var matches 3 if score #cut_b dr_var matches 3 run scoreboard players set #cut_fill dr_var 5
execute if score #cut_a dr_var matches 3 if score #cut_b dr_var matches 5 run scoreboard players set #cut_fill dr_var 5
execute if score #cut_a dr_var matches 5 if score #cut_b dr_var matches 3 run scoreboard players set #cut_fill dr_var 5
execute if score #cut_a dr_var matches 5 if score #cut_b dr_var matches 5 run scoreboard players set #cut_fill dr_var 5
execute if score #cut_a dr_var matches 5 if score #cut_b dr_var matches 0..2 run scoreboard players operation #cut_fill dr_var = #cut_b dr_var
execute if score #cut_b dr_var matches 5 if score #cut_a dr_var matches 0..2 run scoreboard players operation #cut_fill dr_var = #cut_a dr_var
execute if score #cut_fill dr_var matches 0.. run return run function derailed:dev/gen/_cut_fill_run

scoreboard players set #cut_len dr_var 0
execute as @e[type=marker,tag=dr_cut,distance=0..] if score @s dr_step = #cut_r dr_var run scoreboard players add #cut_len dr_var 1
scoreboard players set #cut_lo dr_var 1
scoreboard players operation #cut_hi dr_var = #cut_len dr_var
function derailed:dev/gen/_cut_pair
