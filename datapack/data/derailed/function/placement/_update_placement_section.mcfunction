
# The model dispatches on stack count, so setting the count picks the model
scoreboard players operation #display_count dr_temp = #items_to_place dr_arg
execute store result entity @n[type=item_display,distance=..0.1,tag=dr_placement] item.count int 1 run scoreboard players operation #display_count dr_temp < $BatchHeight dr_const

# A pile only becomes solid at three high, and gains another shulker for every
#  section above that. Below three it is walked through, so any shulker left
#  from a taller pile goes
execute if score @s dr_count matches 3.. positioned ~ ~-0.25 ~ unless entity @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] \
    run summon item_display ~ ~ ~ {Passengers:[{id:shulker,Invulnerable:true,NoAI:true,Health:1,attributes:[{id:scale,base:0.562}],active_effects:[{id:invisibility,duration:-1,show_particles:false}]}],Tags:[dr_placement_shulker]}
execute unless score @s dr_count matches 3.. positioned ~ ~-0.25 ~ as @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] \
    run function derailed:placement/_remove_shulker

tellraw @a [{text:"Display count: "}, {score:{name:"#display_count",objective:dr_temp}}]
execute if score #display_count dr_temp matches 1 positioned ~ ~-0.25 ~ run return run tp @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] ~ ~-0.437 ~
execute if score #display_count dr_temp matches 2 positioned ~ ~-0.25 ~ run return run tp @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] ~ ~-0.062 ~
execute if score #display_count dr_temp matches 3 positioned ~ ~-0.25 ~ run return run tp @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] ~ ~0.313 ~
