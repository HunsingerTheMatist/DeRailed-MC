# Puts this thrown pile's items down where it came to rest, and removes it
# In water, or resting on a player, the train or a pile of another item, it goes
#  back along the way it was thrown until it is out of the water or clear of
#  that, and puts them down there
# Run as the thrown display, at it

scoreboard players operation #curr_item dr_arg = @s dr_item
scoreboard players operation #curr_item_count dr_arg = @s dr_count
execute store result score #curr_rotation dr_arg run data get entity @s Rotation[0]

# What it rests on, anything of those just under its box
execute positioned ~-0.5 ~-1 ~-0.5 as @e[tag=dr_hard,tag=!dr_pile_box,dx=0,dy=0,dz=0] run tag @s add dr_toss_under
execute positioned ~-0.5 ~-1 ~-0.5 as @e[type=interaction,tag=dr_placement,dx=0,dy=0,dz=0] unless score @s dr_item = #curr_item dr_arg run tag @s add dr_toss_under

# Why it goes back, if it does: 1 for what it rests on, 2 for water
scoreboard players set #toss_back dr_temp 0
execute if entity @e[tag=dr_toss_under] run scoreboard players set #toss_back dr_temp 1
execute if block ~ ~ ~ water run scoreboard players set #toss_back dr_temp 2

execute if score #toss_back dr_temp matches 1.. run function derailed:toss/_land_back
execute if score #toss_back dr_temp matches 0 run function derailed:toss/_land_here
tag @e[tag=dr_toss_under] remove dr_toss_under
function derailed:toss/_remove
