# Merges this thrown pile of a resource into the piles of the same item its box
#  touches, as far as each takes it, the piles holding the most first, then
#  shrinks what is left to fit, or removes it where nothing is
# A pile's interaction stands a little wider and taller than what stops the
#  thrown pile, so it touches once the thrown pile has stopped against the pile
# The box tested is a block across, a little wider than the thrown pile's, and
#  a whole number of blocks tall
# Run as the thrown display, at it
#
# Returns 1 when it was removed, fail otherwise

execute unless score @s dr_item <= $LastResource dr_const run return fail
scoreboard players operation #toss_item dr_temp = @s dr_item
scoreboard players operation #toss_before dr_temp = @s dr_count
scoreboard players operation #curr_item dr_arg = @s dr_item
scoreboard players operation #curr_item_count dr_arg = @s dr_count
function derailed:toss/_box_height

execute if score #toss_h dr_temp matches ..10000 positioned ~-0.5 ~ ~-0.5 as @e[type=interaction,tag=dr_placement,dx=0,dy=0,dz=0] if score @s dr_item = #toss_item dr_temp run tag @s add dr_toss_touch
execute if score #toss_h dr_temp matches 10001..20000 positioned ~-0.5 ~ ~-0.5 as @e[type=interaction,tag=dr_placement,dx=0,dy=1,dz=0] if score @s dr_item = #toss_item dr_temp run tag @s add dr_toss_touch
execute if score #toss_h dr_temp matches 20001.. positioned ~-0.5 ~ ~-0.5 as @e[type=interaction,tag=dr_placement,dx=0,dy=2,dz=0] if score @s dr_item = #toss_item dr_temp run tag @s add dr_toss_touch
function derailed:toss/_merge_most
tag @e[type=interaction,tag=dr_toss_touch,distance=..4] remove dr_toss_touch

execute if score @s dr_count = #toss_before dr_temp run return fail
execute if score @s dr_count matches ..0 run return run function derailed:toss/_remove

scoreboard players operation #curr_item_count dr_arg = @s dr_count
function derailed:toss/_box_height
execute store result entity @s item.count int 1 run scoreboard players get #curr_item_count dr_arg
execute on passengers store result entity @s height float 0.0001 run scoreboard players get #toss_h dr_temp
return fail
