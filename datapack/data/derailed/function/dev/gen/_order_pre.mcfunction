
# Runs the order check on the first route alone and leaves '#opre' at 1 where
#  a level the route reaches cannot be paid for and '_order_fix' would have no
#  region to make wood, which the supply's repaints almost never change
# A tile of the route lies past the last level paid for where the furthest the
#  route reached is past it, or where the flood stopped before reaching every
#  tile of the route
# Positioned at the section's corner, with the first route drawn two above and
#  the layer above it clear

function derailed:dev/gen/_order
scoreboard players set #olate dr_var 0
execute if score #ormax dr_var > #oL dr_var run scoreboard players set #olate dr_var 1
execute if score #orn dr_var < #gen_route dr_var run scoreboard players set #olate dr_var 1
execute if score #olate dr_var matches 1 run function derailed:dev/gen/_order_cands
execute if score #olate dr_var matches 1 unless entity @e[type=marker,tag=dr_ocand,distance=0..] run scoreboard players set #opre dr_var 1
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ocand
scoreboard players set #order_ran dr_var 0
