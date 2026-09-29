
# Runs the order check on the first route alone and leaves '#opre' at 1 where
#  a level the route reaches cannot be paid for and '_order_fix' would have no
#  region to make wood, which the supply's repaints almost never change
# Positioned at the section's corner, with the first route drawn two above and
#  the layer above it clear

function derailed:dev/gen/_order
execute if score #ormax dr_var > #oL dr_var run function derailed:dev/gen/_order_cands
execute if score #ormax dr_var > #oL dr_var unless entity @e[type=marker,tag=dr_ocand,distance=0..] run scoreboard players set #opre dr_var 1
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ocand
scoreboard players set #order_ran dr_var 0
