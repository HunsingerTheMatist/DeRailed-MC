
# TODO: Change interaction size and add resource entities based on stack size
# Maybe have the block displays (or whatever entity we use) ride the interaction

scoreboard players operation #stack_height dr_temp = @s dr_count
execute store result entity @s height float 0.01 run scoreboard players operation #stack_height dr_temp *= $ResourcePhysicalHeight dr_const

scoreboard players operation #resources_to_place dr_arg = @s dr_count

tellraw @a [{score:{objective:"dr_arg",name:"#resources_to_place"}}]
execute positioned ~ ~0.5 ~ run function derailed:resource/update_resource_step

# Remove empty piles
execute if score @s dr_count matches ..0 run kill @s
